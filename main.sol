// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract OnchainPong {
    struct Player {
        address playerAddress;
        uint position; // Position of paddle (0-100)
    }

    struct Game {
        Player player1;
        Player player2;
        uint ballX;
        uint ballY;
        int ballDirectionX;
        int ballDirectionY;
        uint lastUpdated;
        bool isActive;
    }

    mapping(uint => Game) public games;
    uint public gameCount;

    event GameStarted(uint gameId, address player1, address player2);
    event GameUpdated(uint gameId, uint ballX, uint ballY, uint player1Pos, uint player2Pos);
    event GameEnded(uint gameId, address winner);

    function startGame(address _player2) external {
        gameCount++;
        games[gameCount] = Game({
            player1: Player(msg.sender, 50),
            player2: Player(_player2, 50),
            ballX: 50,
            ballY: 50,
            ballDirectionX: 1,
            ballDirectionY: 1,
            lastUpdated: block.timestamp,
            isActive: true
        });
        emit GameStarted(gameCount, msg.sender, _player2);
    }

    function movePaddle(uint gameId, uint newPosition) external {
        require(games[gameId].isActive, "Game not active");
        require(newPosition <= 100, "Position out of bounds");
        if (msg.sender == games[gameId].player1.playerAddress) {
            games[gameId].player1.position = newPosition;
        } else if (msg.sender == games[gameId].player2.playerAddress) {
            games[gameId].player2.position = newPosition;
        } else {
            revert("Not a player");
        }
        updateGame(gameId);
    }

    function updateGame(uint gameId) public {
        Game storage game = games[gameId];
        require(game.isActive, "Game not active");

        uint timeElapsed = block.timestamp - game.lastUpdated;
        game.ballX = uint(int(game.ballX) + game.ballDirectionX * int(timeElapsed));
        game.ballY = uint(int(game.ballY) + game.ballDirectionY * int(timeElapsed));
        game.lastUpdated = block.timestamp;

        if (game.ballX >= 100 || game.ballX <= 0) {
            game.isActive = false;
            address winner = game.ballX >= 100 ? game.player1.playerAddress : game.player2.playerAddress;
            emit GameEnded(gameId, winner);
        } else {
            emit GameUpdated(gameId, game.ballX, game.ballY, game.player1.position, game.player2.position);
        }
    }
}

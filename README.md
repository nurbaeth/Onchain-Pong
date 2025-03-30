# Onchain Pong 🏓

**Onchain Pong** is a fully on-chain implementation of the classic Pong game written in Solidity. Players can control paddles via smart contract transactions, and the ball moves based on blockchain timestamps. The game is purely for fun, with no bets or rewards.

## Features ✨
- 🎮 **Fully on-chain**: All game logic runs on Ethereum-compatible blockchains.
- ⏳ **Time-based ball movement**: The ball position updates based on `block.timestamp`.
- 👤 **Two-player interaction**: Players can control their paddles by sending transactions.
- 🚀 **No off-chain dependencies**: Everything is managed within the smart contract.

## How It Works ⚙️
1. **Start a Game**: A player initializes a game and invites an opponent.
2. **Move Paddles**: Players adjust their paddle positions by calling the `movePaddle` function.
3. **Ball Movement**: The ball updates automatically based on elapsed time. 
4. **Winning Condition**: The game ends when the ball reaches the left or right boundary.

## Smart Contract Functions 📜
- `startGame(address _player2)`: Creates a new game between two players.
- `movePaddle(uint gameId, uint newPosition)`: Moves a player's paddle.
- `updateGame(uint gameId)`: Updates the ball position and checks for a winner.

## Deployment 🚀
To deploy the contract, use Hardhat or Remix:
```sh
npx hardhat compile
npx hardhat deploy --network goerli
```
Or directly deploy via [Remix](https://remix.ethereum.org/).

## Future Enhancements 🔮
- 🔄 Improved ball physics
- 🎭 NFT-based paddle skins
- 🏆 On-chain leaderboard

## License 📝
This project is licensed under the MIT License.


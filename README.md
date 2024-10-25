# tetris_flutter

The project implements a classic Tetris game using Flutter. It features a game board, various Tetromino pieces, scoring, game over conditions, pause functionality, and exit options.
Functionality:

Game Board: The game board is represented by a grid layout where Tetromino pieces fall and land. The board is created using a GridView.builder for dynamic tile rendering.

Tetromino Pieces: The game utilizes various Tetromino shapes (L, J, I, O, S, Z, T) that randomly spawn and fall from the top of the board. These pieces are represented using custom classes and logic for movement and rotation.

Movement and Rotation: Players can control the falling Tetromino pieces by moving them left, right, and rotating them using on-screen buttons. Collision detection is implemented to prevent pieces from moving beyond the board boundaries or overlapping with existing landed pieces.

Landing and Line Clearing: When a Tetromino piece lands, it becomes part of the game board. If a horizontal line is completely filled with landed pieces, it is cleared, and the player's score increases.

Scoring: The game keeps track of the player's score, which increases as lines are cleared. The score is displayed on the screen.

Game Over: The game ends when landed pieces stack up and reach the top of the board, preventing new pieces from spawning. A game over dialog is presented, showing the player's final score and options to play again or exit.

Pause Functionality: The game can be paused and resumed using a pause button. This temporarily stops the falling of Tetromino pieces.

Exit Option: Players have the option to exit the game using a back button or through the game over dialog.

https://github.com/user-attachments/assets/56b233ca-1101-4f4c-b1ce-5a765f8106d7

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

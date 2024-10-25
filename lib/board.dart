import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';
import 'package:audioplayers/audioplayers.dart';

// Game-board
List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(
          rowLength,
          (j) => null,
        ));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  int rowLength = 10;
  int colLength = 15;

  Piece currentPiece = Piece(type: Tetromino.L);

  int currentScore = 0;
  bool gameOver = false;

  bool isPaused = false;
  Timer? gameTimer;

  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initialPiece();

    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(frameRate, (timer) {
      if (!isPaused) {
        setState(() {
          clearLines();
          checkLanding();
          if (gameOver) {
            timer.cancel();
            showGameOverDialog();
          }
          currentPiece.movePiece(Direction.down);
        });
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text("Your Score is: $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text('Exit Game'),
          ),
        ],
      ),
    );
  }

  void showGameExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Want to Leave the Game ?'),
        content: Text("Your Current Score is: $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
        colLength,
        (i) => List.generate(
              rowLength,
              (j) => null,
            ));

    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }
  // Returns true of collision
  // Return false if collision

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculating the row and column of the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
        if (col < 0 ||
            (row >= 0 && row < colLength && gameBoard[row][col] != null)) {
          return true;
        }
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the price is out of bound
      if (row >= colLength ||
          col < 0 ||
          col >= rowLength ||
          (row >= 0 && col >= 0 && gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initialPiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left) && !isPaused) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
      //player.play('glass-knock.mp3');
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right) && !isPaused) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
      //player.play(AssetSource('glass-knock.mp3'));
    }
  }

  void rotatePiece() {
    if (!isPaused) {
      setState(() {
        currentPiece.rotatePiece();
      });
      //player.play('glass-knock.mp3');
    }
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 36.0,
            right: 12.0,
            child: IconButton(
              icon: Icon(
                isPaused ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 45,
              ),
              onPressed: (){
                setState(() {
                  isPaused = !isPaused;
                });
                gameLoop(const Duration(milliseconds: 500));
              },
            ),
          ),
          Positioned(
            top: 36.0,
            left: 12.0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 45,
              ),
              onPressed: showGameExitDialog,
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 85.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: rowLength * colLength,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;

                    if (currentPiece.position.contains(index)) {
                      return Pixel(
                        color: currentPiece.color,
                        child: index,
                      );
                    } else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(
                          color: tetrominoColors[tetrominoType], child: '');
                    } else {
                      return Pixel(
                        color: Colors.grey[900],
                        child: index,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Score: $currentScore',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: isPaused ? null : moveLeft,
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back_ios, size: 35)),
                    IconButton(
                        onPressed: isPaused ? null : rotatePiece,
                        color: Colors.white,
                        icon: Icon(Icons.rotate_right, size: 45)),
                    IconButton(
                        onPressed: isPaused ? null : moveRight,
                        color: Colors.white,
                        icon: Icon(Icons.arrow_forward_ios, size: 35)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

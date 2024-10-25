import 'dart:ui';

import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

enum Direction{
  left,
  right,
  down,
}

enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors ={
  Tetromino.T: Colors.red,
  Tetromino.I: Colors.yellowAccent,
  Tetromino.J: Colors.green,
  Tetromino.L: Colors.lightBlueAccent,
  Tetromino.O: Colors.purple,
  Tetromino.S: Colors.blueAccent,
  Tetromino.Z: Colors.orange,
};
import 'dart:collection';
import 'dart:ui';

import 'package:biliard_client/drawing_bloc/drawing_bloc.dart';
import 'package:flutter/material.dart';

class MainPainter extends CustomPainter {
  final double painterWidth, painterHeight;
  final DrawingState drawingState;
  MainPainter(this.painterWidth, this.painterHeight, this.drawingState);
  @override
  void paint(Canvas canvas, Size size) {
    final Map<Color, Set<Offset>> map = HashMap();

    canvas.drawRawPoints(
      PointMode.points,
      drawingState.positions,
      Paint()
        ..color = Colors.red
        ..blendMode = BlendMode.srcOver
        ..strokeWidth = 10.0,
    );
  }

  bool shouldRepaint(MainPainter oldDelegate) => true;
}

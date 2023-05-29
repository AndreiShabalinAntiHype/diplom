import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:biliard_client/drawing_bloc/drawing_bloc.dart';
import 'package:biliard_client/painters/figure_painter.dart';
import 'package:flutter/material.dart';

class MainPainter extends CustomPainter {
  final double painterWidth, painterHeight;
  final DrawingState drawingState;
  MainPainter(this.painterWidth, this.painterHeight, this.drawingState);
  @override
  void paint(Canvas canvas, Size size) {
    final Map<Color, Set<Offset>> map = HashMap();

Offset center = Offset(250, 250);
Rect rect = Rect.fromCircle(center: center, radius: 200);
Path path = Path()
  // set the "current point"
  ..moveTo(center.dx, center.dy)
  ..arcTo(rect, pi / 4, pi / 2, true);
FigurePainter.drawFigury(canvas, painterWidth, painterHeight);
    canvas.drawRawPoints(
      PointMode.points,
      drawingState.positions,
      Paint()
        ..color = Colors.red
        ..blendMode = BlendMode.srcOver
        ..strokeWidth = 5,
);
  }

  bool shouldRepaint(MainPainter oldDelegate) => true;







}

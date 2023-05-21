import 'dart:collection';
import 'dart:math';
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

Offset center = Offset(250, 250);
Rect rect = Rect.fromCircle(center: center, radius: 200);
Path path = Path()
  // set the "current point"
  ..moveTo(center.dx, center.dy)
  ..arcTo(rect, pi / 4, pi / 2, true);
drawFigure(canvas, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 3);


    // canvas.drawCircle(Offset(painterWidth / 2,-150),470, Paint()..color = Colors.black..style = PaintingStyle.stroke);

    canvas.drawRawPoints(
      PointMode.points,
      drawingState.positions,
      Paint()
        ..color = Colors.red
        ..blendMode = BlendMode.srcOver
        ..strokeWidth = 1.5,
    );
  }

  bool shouldRepaint(MainPainter oldDelegate) => true;





void drawFigure(Canvas canvas, Paint paint) {

  final point1 = Offset(painterWidth / 6, painterHeight);
  final point2 = Offset(painterWidth / 6, painterHeight / 6);
  final point3 = Offset(painterWidth / 6 * 8, painterHeight);

  canvas.drawLine(point1, point2, paint);
    canvas.drawLine(point1, point3, paint);
  canvas.drawCircle(Offset(painterWidth * 2 / 3, -painterHeight / 1.83), sqrt(painterWidth * 100 * 5.5), paint);


    // canvas.drawCircle(Offset(painterWidth * 4 / 3, painterHeight), sqrt(painterWidth * 80 * 5.5), paint);

  final intersectionPoiint = getLeftCircleIntersectionPoint(Offset(painterWidth * 4 / 3, painterHeight),sqrt(painterWidth * 80 * 5.5), Offset(painterWidth * 2 / 3, -painterHeight / 1.83), sqrt(painterWidth * 100 * 5.5));

  // canvas.drawArc(Rect.fromCircle(center: Offset(painterWidth * 4 / 3, painterHeight), radius: sqrt(painterWidth * 80 * 5.5)), pi, angleBetweenPointsOnCircle(center, radius, point1, intersectionPoiint!), false, paint);
}

double angleBetweenPointsOnCircle(Offset center, double radius, Offset point1, Offset point2) {
  // Calculate the distance between the two points
  final distance =sqrt((point1.dx - point2.dx) *(point1.dx - point2.dx)  + (point1.dy - point2.dy) *  (point1.dy - point2.dy));

  // Calculate the angle using the law of cosines
  final angle = acos((2 * pow(radius, 2) - pow(distance, 2)) / (2 * pow(radius, 2)));

  // Determine if the angle is positive or negative based on the orientation of the points
  final orientation = (point1.dx - center.dx) * (point2.dy - center.dy) - (point1.dy - center.dy) * (point2.dx - center.dx);
  final sign = orientation.sign;

  // Return the angle in radians
  return angle * sign;
}


Offset? getLeftCircleIntersectionPoint(Offset c1, double r1, Offset c2, double r2) {
  // Calculate the distance between the centers of the circles
  final d = (c1.dx - c2.dx) * (c1.dy - c2.dy) - (c1.dy - c2.dy) * (c1.dx - c2.dx);

  // Check if the circles are too far apart to intersect
  if (d > r1 + r2) {
    return null;
  }

  // Check if one circle is contained within the other
  if (d < (r1 - r2).abs()) {
    return null;
  }

  // Calculate the distance from c1 to the midpoint between the intersection points
  final a = (pow(r1, 2) - pow(r2, 2) + pow(d, 2)) / (2 * d);

  // Calculate the height of the triangle formed by c1, the midpoint, and one intersection point
  final h = sqrt(pow(r1, 2) - pow(a, 2));

  // Calculate the midpoint between the intersection points
  final p = c1 + (c2 - c1) * (a / d);

  // Calculate the left intersection point
  final i = p + Offset(h * (c2.dy - c1.dy) / d, -h * (c2.dx - c1.dx) / d);

  // Return the left intersection point
  return i;
}
}

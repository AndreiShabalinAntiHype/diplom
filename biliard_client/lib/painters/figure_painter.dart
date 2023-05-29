import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FigurePainter {
  
  static Offset  topCirclesCenter(double painterWidth, double painterHeight) {
    return getTopmostCircleIntersectionPoint(Circle(painterWidth / 6* 5,  painterHeight /3, painterHeight ), Circle(painterWidth / 6 , painterHeight / 6,painterHeight ));
  }



    
  static Offset  leftCirclesCenter(double painterWidth, double painterHeight) {
    return getLeftmostCircleIntersectionPoint(Circle(painterWidth / 6* 5,painterHeight - painterHeight / 6, painterHeight ), Circle(painterWidth / 6* 5,  painterHeight * 2   / 6,painterHeight ));
  }

  static drawFigury(Canvas canvas, double painterWidth, double painterHeight) {
drawArcByPoints(canvas, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 3, Offset(painterWidth / 6* 5,  painterHeight /3),Offset(painterWidth / 6 , painterHeight / 6), painterHeight);
drawArcByPoints(canvas, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 3,Offset(painterWidth / 6* 5,painterHeight - painterHeight / 6), Offset(painterWidth / 6* 5,  painterHeight * 2   / 6), painterHeight);
canvas.drawLine(Offset(painterWidth / 6* 5,  painterHeight - painterHeight / 6), Offset(painterWidth / 6 , painterHeight - painterHeight / 6),Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2);
canvas.drawLine(Offset(painterWidth / 6, painterHeight - painterHeight / 6 ),Offset(painterWidth / 6,  painterHeight    / 6 ), Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2 );
  }
  static void drawArcByPoints(Canvas canvas, Paint paint, Offset startPoint, Offset endPoint, double radius) {

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..arcToPoint(
        endPoint,
        radius: Radius.circular(radius),
        clockwise: true,
      );

    canvas.drawPath(path, paint);
  }
}



class Circle {
  final double x;
  final double y;
  final double r;

  const Circle(this.x, this.y, this.r);
}


List<Offset> getCircleIntersectionPoints(Circle c1, Circle c2) {
  final d = sqrt(pow(c2.x - c1.x, 2) + pow(c2.y - c1.y, 2));
  if (d > c1.r + c2.r) {
    return [];
  }
  if (d < (c1.r - c2.r).abs()) {
    return [];
  }
  final a = (pow(c1.r, 2) - pow(c2.r, 2) + pow(d, 2)) / (2 * d);
  final h = sqrt(pow(c1.r, 2) - pow(a, 2));
  final x2 = c1.x + a * (c2.x - c1.x) / d;
  final y2 = c1.y + a * (c2.y - c1.y) / d;
  final x3 = x2 + h * (c2.y - c1.y) / d;
  final y3 = y2 - h * (c2.x - c1.x) / d;
  final x4 = x2 - h * (c2.y - c1.y) / d;
  final y4 = y2 + h * (c2.x - c1.x) / d;
  return [Offset(x3, y3), Offset(x4, y4)];
}

Offset getTopmostCircleIntersectionPoint(Circle c1, Circle c2) {
  final intersectionPoints = getCircleIntersectionPoints(c1, c2);
  Offset topmostPoint = intersectionPoints.first;
  for (final point in intersectionPoints) {
    if (point.dy < topmostPoint.dy) {
      topmostPoint = point;
    }
  }
  return topmostPoint;
}


Offset getLeftmostCircleIntersectionPoint(Circle c1, Circle c2) {
  final intersectionPoints = getCircleIntersectionPoints(c1, c2);
  Offset leftMostPoint = intersectionPoints.first;
  for (final point in intersectionPoints) {
    if (point.dx > leftMostPoint.dx) {
      leftMostPoint = point;
    }
  }
  return leftMostPoint;
}
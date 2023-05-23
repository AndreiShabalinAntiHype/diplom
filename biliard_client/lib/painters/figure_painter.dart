import 'dart:ui';

import 'package:flutter/material.dart';

class FigurePainter {
  static drawFigury(Canvas canvas, double painterWidth, double painterHeight) {
drawArcByPoints(canvas, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 3, Offset(painterWidth / 6* 5,  painterHeight * 2   / 6),Offset(painterWidth / 6 , painterHeight / 6), painterHeight);
drawArcByPoints(canvas, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 3,Offset(painterWidth / 6* 4.9,painterHeight - painterHeight / 6), Offset(painterWidth / 6* 5,  painterHeight * 2   / 6), painterHeight);
canvas.drawLine(Offset(painterWidth / 6* 4.9,  painterHeight - painterHeight / 6), Offset(painterWidth / 6 , painterHeight - painterHeight / 6),Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2);
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

  static Offset newVelocityVect(Offset hitCords, painterWidth, oldVelocityVect, ) {
    //Left
    if (hitCords.dx < painterWidth / 6 ) {
      return Offset();
    } 
    //Right
    else /*if (hitCords.dx > painterWidth / 6* 5)*/ {
      return Offset();
    }
    // //Top
    // else if (hitCords.dy) {

    // }
    // //Bottom
    // else {

    // }
  }
}
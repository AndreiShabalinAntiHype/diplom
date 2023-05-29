import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:web_ffi/web_ffi.dart';

import '../painters/figure_painter.dart';

enum FigureSide {
  left,
  top,
  right,
  bottom,
}


class DrawingRepo {
  final List<double> positions = [];
  final double startingX = 400,startingY = 400;
  late Size painterSize;
  Float32List get getRawPos => Float32List.fromList(positions);
  late Offset topCirclesCenter;
  late Offset leftCirclesCenter;
  late double circlesRadius;
  List<Uint16> vVectors = [];
  int numOfPoints = 5;
  List<double> shifts = [];
  List<FigureSide> nextReflections = [];
  double get painterWidth => painterSize.width;
  double get painterHeight => painterSize.height;
  double get bottomLineY =>  (painterHeight - painterHeight / 6);
  double get leftLineX => (painterWidth / 6);
  bool isMoving = false;

  double? topT;
  double? topL;
  double? xR;
  double? yR;

  DrawingRepo() {
    initialPos();
  }

  updateN(int n) {
    numOfPoints = n;
    initialPos();
  }

  updatePos() {
    for (int i = 0;i < positions.length - 1; i+=2) {
      positions[i] += shifts[i];
      positions[i + 1] += shifts[i + 1];
      if (nextReflections[i ~/ 2] == FigureSide.bottom) {
        if (positions[i+1] >= bottomLineY) {
          shifts[i+1] = -shifts[i+1];
          nextReflections[i ~/ 2] =  nextReflection(positions[i], positions[i + 1], i);
        }
      }
      else if (nextReflections[i ~/ 2] == FigureSide.left) {
        if (positions[i] <= leftLineX) {
          shifts[i] = -shifts[i];
          nextReflections[i ~/ 2] =  nextReflection(positions[i], positions[i + 1], i);
        }
      }
      else if (nextReflections[i ~/ 2] == FigureSide.top) {
        if (pow(positions[i]  - topCirclesCenter.dx, 2) + pow(positions[i+1] - topCirclesCenter.dy , 2) - pow(circlesRadius, 2) < 0) {
          double xs = positions[i] - shifts[i];
          double ys = positions[i + 1] - shifts[i + 1];

          double cost0 = (xs - topCirclesCenter.dx) / circlesRadius;
          double sint0 = (ys - topCirclesCenter.dy) / circlesRadius;

          double cos2t = (pow(cost0, 2) - pow(sint0, 2)).toDouble();
          double sin2t = 2 * sint0 * cost0;

          double m1 = -shifts[i] * cos2t - shifts[i+1] * sin2t;
          double n1 = -shifts[i] * sin2t + shifts[i+1] * cos2t;

          shifts[i] = m1;
          shifts[i+1] = n1;

          shifts[i] = m1 / sqrt(m1 * m1 + n1 * n1);
          shifts[i+1] = n1 / sqrt(m1 * m1 + n1 * n1);

          nextReflections[i ~/ 2] =  nextReflection(xs, ys, i);
        }
      }
      else {
        if (pow(positions[i] - leftCirclesCenter.dx, 2) + pow(positions[i+1] - leftCirclesCenter.dy , 2) - pow(circlesRadius, 2) < 0) {
          double xs = positions[i] - shifts[i];
          double ys = positions[i + 1] - shifts[i + 1];

          double cost0 = (xs - leftCirclesCenter.dx) / circlesRadius;
          double sint0 = (ys - leftCirclesCenter.dy) / circlesRadius;

          double cos2t = (pow(cost0, 2) - pow(sint0, 2)).toDouble();
          double sin2t = 2 * sint0 * cost0;

          double m1 = -shifts[i] * cos2t - shifts[i+1] * sin2t;
          double n1 = -shifts[i] * sin2t + shifts[i+1] * cos2t;

          shifts[i] = m1 / sqrt(m1 * m1 + n1 * n1);
          shifts[i+1] = n1 / sqrt(m1 * m1 + n1 * n1);

          nextReflections[i ~/ 2] =  nextReflection(xs, ys, i);
        }
      }
    }
  }

  calculateNextReflectionsSide() {
    nextReflections.clear();
    for (int i = 0;i < shifts.length -1 ;i+=2) {
      shifts[i] = shifts[i] / sqrt(shifts[i] * shifts[i] + shifts[i+1] * shifts[i+1]);
      shifts[i+1] = shifts[i+1] / sqrt(shifts[i] * shifts[i] + shifts[i+1] * shifts[i+1]);
      nextReflections.add(nextReflection(positions[i], positions[i + 1], i));
    }
  }

  initialPos() {
    positions.clear();
    shifts.clear();
    final rows = sqrt(findNearestSquareLessThan(numOfPoints));
    for (int i = 0;i<rows; i++ ) {
      for (int j = 0;j<rows; j++) {
        positions.add(startingX + j * 2 - i);
        positions.add(startingY + i * 2);
        shifts.add(-1);
        shifts.add(1);
      }
    } 
  } 

  setPainterSize(Size s) {
    painterSize = s;
    topCirclesCenter = FigurePainter.topCirclesCenter(painterWidth, painterHeight);
    leftCirclesCenter = FigurePainter.leftCirclesCenter(painterWidth, painterHeight);
    circlesRadius = painterHeight.roundToDouble();
  }

  int findNearestSquareLessThan(int num) {
  int sqrtNum = sqrt(num).toInt();
  int lowerSquare = sqrtNum * sqrtNum;
  

  return lowerSquare;
}

  FigureSide nextReflection(double x0, double y0,int i ) {
    double t1 = shifts[i] < 0 ? (leftLineX - x0) / shifts[i] : double.infinity;

    double t2 = shifts[i+1] > 0 ? (bottomLineY - y0) / shifts[i+1] : double.infinity;

    double t3 = shifts[i] * (topCirclesCenter.dx - x0) + shifts[i+1] * (topCirclesCenter.dy - y0) - 
    sqrt(pow(shifts[i] * (topCirclesCenter.dx - x0) + shifts[i+1] * (topCirclesCenter.dy - y0),2)
    -pow(topCirclesCenter.dx - x0, 2) - pow(topCirclesCenter.dy - y0, 2)  + pow(circlesRadius, 2));

    double t4 = shifts[i] * (leftCirclesCenter.dx - x0) + shifts[i+1] * (leftCirclesCenter.dy - y0) - 
    sqrt(pow(shifts[i] * (leftCirclesCenter.dx - x0) + shifts[i+1] * (leftCirclesCenter.dy - y0),2)
    -pow(leftCirclesCenter.dx - x0, 2) - pow(leftCirclesCenter.dy - y0, 2)  + pow(circlesRadius, 2));

    t3 = t3.isNaN ? double.infinity : t3;
    t3 = t3 < 0 ? double.infinity : t3;

    
    t4 = t4.isNaN ? double.infinity : t4;
    t4 = t4 < 0 ? double.infinity : t4;
   
    // if ((t2) < 4) {
    //   shifts[i + 1] = -shifts[i + 1];
    // }

    // if (t3 < 4) {
    //   shifts[i + 1] = -shifts[i + 1];
    // }

    if (t1 < t2 && t1 < t3 && t1 <t4) {
      return FigureSide.left;
    }
    else if (t2 < t3 && t2 < t4) {
      return FigureSide.bottom;
    }
    else if (t3 < t4) {
      topT = t3;
      return FigureSide.top;
    }
    else  {
      topL = t4;
      return FigureSide.right;
    }
  }

  stop() {
    isMoving = false;
  }

  start() {
    isMoving = true;
    calculateNextReflectionsSide();
  }
}

import 'dart:math';
import 'dart:typed_data';

import 'package:web_ffi/web_ffi.dart';

class DrawingRepo {
  final List<double> positions = [];
  final double startingX = 200,startingY = 200;
  Float32List get getRawPos => Float32List.fromList(positions);
  List<Uint16> vVectors = [];
  int numOfPoints = 100;
  List<double> shifts = [];
  DrawingRepo() {
    initialPos();
  }

  updateN(int n) {
    numOfPoints = n;
    initialPos();
  }

  updatePos() {
        for (int i = 0;i < positions.length; i++) {
      positions[i] += shifts[i];
    }
  }
  initialPos() {
    positions.clear();

    final rows = sqrt(findNearestSquareLessThan(numOfPoints));
    for (int i = 0;i<rows; i++ ) {
      for (int j = 0;j<rows; j++) {
        positions.add(startingX + j * 2);
        positions.add(startingX + i * 2);
              shifts.add(6);
      shifts.add(0);
      }
    } 
  }


  int findNearestSquareLessThan(int num) {
  int sqrtNum = sqrt(num).toInt();
  int lowerSquare = sqrtNum * sqrtNum;
  
  return lowerSquare;
}
}

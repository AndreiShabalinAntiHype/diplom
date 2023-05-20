import 'package:web_ffi/web_ffi.dart';

class DrawingRepo {
  List<Uint16> positions = [];
  List<Uint16> vVectors = [];
  int numOfPoints = 100;
  double startingAngle = 0;
  DrawingRepo();

  updateN(int n) {
    numOfPoints = n;
  }

  updateAngle(double angle) {
    startingAngle = angle;
  }

  updatePos() {}

  updateV() {}
}

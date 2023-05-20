part of 'drawing_bloc.dart';

class DrawingState {
  int numOfPoints = 100;
  double startingAngle = 0;
  final positions =
      Float32List.fromList([50, 50, 100, 100, 200, 200, 300, 300, 400, 400]);
  final vVectors = Uint16List.fromList([]);
  DrawingState({int? n, double? angle}) {
    if (n != null) {
      numOfPoints = n;
    }
    if (angle != null) {
      startingAngle = angle;
    }
  }
}

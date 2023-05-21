part of 'drawing_bloc.dart';

class DrawingState {
  int numOfPoints = 100;
  final Float32List positions;
  final vVectors = Uint16List.fromList([]);
  DrawingState( this.positions, {int? n, double? angle}) {
    if (n != null) {
      numOfPoints = n;
    }
  }
}

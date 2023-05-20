part of 'drawing_bloc.dart';

abstract class DrawingEvent {
  const DrawingEvent();
}

class UpdateAngle extends DrawingEvent {
  num angle;
  UpdateAngle(this.angle);
}

class UpdateN extends DrawingEvent {
  num n;
  UpdateN(this.n);
}

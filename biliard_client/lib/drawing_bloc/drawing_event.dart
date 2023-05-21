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

class UpdatePoints extends DrawingEvent {
  UpdatePoints();
}

class UpdatePos extends DrawingEvent {
  UpdatePos();
}

class UpdateR extends DrawingEvent {
  final double r;
  UpdateR(this.r);
}
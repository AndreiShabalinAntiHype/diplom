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

class StopMoving extends DrawingEvent {
  StopMoving();
}

class StartMoving extends DrawingEvent {
  StartMoving();
}

class SetPainterSize extends DrawingEvent {
  double w,h;
  SetPainterSize(this.w, this.h);
}
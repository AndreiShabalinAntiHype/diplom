import 'dart:ui';

class Point {
    Offset cords;
    Offset velocityVector;
    Point(this.cords, this.velocityVector);

    Offset newVelocityVect( double painterWidth) {
    //Left
    if (cords.dx <= painterWidth / 6 ) {
      return Offset();
    } 
    //Right
    else if (cords.dx > painterWidth / 6* 5) {
      return Offset();
    }
    //Bottom
    else if (cords.dy <= 0) {
      return Offset();
    }
    //Top
    else {
      return Offset();
    }
}}
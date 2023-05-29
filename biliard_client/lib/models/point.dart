import 'dart:ui';

class Point {
    Offset cords;
    Offset velocityVector;
    Point(this.cords, this.velocityVector);

    bool leftBottomReflection(double painterWidt) {
      if (cords.dx == painterWidt /6) 
{      return true;}
return false;
    }


    bool rigtBottomReflection() {

    
      return true;
    }
    
    bool leftTopReflection() {
      return true;
    }
    
    bool rigtTopReflection() {
      if (cords.dy == 0) {
        return true;
      }
      return false;
    }
  //   Offset newVelocityVect( double painterWidth) {
  //   //Left
  //   if (cords.dx <= painterWidth / 6 ) {
  //     return Offset();
  //   } 
  //   //Right
  //   else if (cords.dx > painterWidth / 6* 5) {
  //     return Offset();
  //   }
  //   //Bottom
  //   else if (cords.dy <= 0) {
  //     return Offset();
  //   }
  //   //Top
  //   else {
  //     return Offset();
  //   }

  // }

}
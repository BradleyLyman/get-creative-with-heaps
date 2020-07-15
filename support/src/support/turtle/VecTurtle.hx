package support.turtle;

import support.linAlg2d.Vec;

/**
    Support operations to make turtles more ergonomic while working with Vecs.

    Example:
      using support.turtle.VecTurtle;
      ...
      turtle.moveToVec([1, 3]);
**/
class VecTurtle {

  /* Move the turtle to the vector position. */
  static public inline function moveToVec(turtle: Turtle, p: Vec) : Turtle {
    return turtle.moveTo(p.x, p.y);
  }

  /* Draw a line from the turtle's current position to the vector position. */
  static public inline function lineToVec(turtle: Turtle, p: Vec) : Turtle {
    return turtle.lineTo(p.x, p.y);
  }
}
package support.turtle;

import support.linAlg2d.Vec;

/**
    A Turtle is a stateful helper for drawing lines on the screen.

    The turtle has a position and knows how to style lines when they're
    added.
**/
interface Turtle {
  /* the turtle's current position */
  var position(get, set): Vec;

  /* the line's width */
  var lineWidth(get, set): Float;

  /**
      Move the turtle to a set of coordinates.
      @return Turtle - this turtle, for method chaining
  **/
  public function moveTo(x: Float, y: Float): Turtle;

  /**
      Draw a line from the current position to the line's position.
      @return Turtle - this turtle, for method chaining
  **/
  public function lineTo(x: Float, y: Float): Turtle;
}
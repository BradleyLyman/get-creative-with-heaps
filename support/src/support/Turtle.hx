package support;

import support.linAlg2d.Vec;
import support.linAlg2d.Line;

/**
    Objects of this type represent all of the lines the turtle has drawn.
**/
interface View {

  /**
      Add a line to the view.
  **/
  public function addLine(line: Line, lineWidth: Float): Void;
}

/**
    A Turtle is a stateful helper for drawing lines on the screen.

    The turtle has a position and knows how to style lines when they're
    added.
**/
class Turtle {
  public final view : View;
  public var lineWidth : Float = 1;
  public var position : Vec = Vec.of(0, 0);

  /**
      Create a new turtle which emits lines to the FastLines instance.
  **/
  public inline function new(view: View) {
    this.view = view;
  }

  /**
      Move the turtle to a new position without emitting any visible geometry.
  **/
  public inline function moveTo(x: Float, y: Float): Turtle {
    position.x = x;
    position.y = y;
    return this;
  }

  /**
      Draw a line from the current position to the new position.
      The turtle's position is updated to the line's endpoint.
  **/
  public inline function lineTo(x: Float, y: Float): Turtle {
    final to = Vec.of(x, y);
    view.addLine(new Line(position, to), lineWidth);
    this.position = to;
    return this;
  }
}

package support.turtle;

import support.color.Color;
import support.linAlg2d.Vec;

/**
    Types which extend this type represent a turtle which modifies the behaviour
    of some other turtle.

    This has all sorts of applications for add coordinate transformations or
    other forms of conditional rendering.
**/
class DecoratedTurtle implements Turtle {
  private final wrapped: Turtle;
  public var position(get, set): Vec;
  public var lineWidth(get, set): Float;
  public var color(get, set): Color;

  /* wrap the provided turtle to apply some modified behaviour */
  public function new(toWrap: Turtle) {
    this.wrapped = toWrap;
  }

  /* move the turtle to a point without emiting any lines */
  public function moveTo(x: Float, y: Float): DecoratedTurtle {
    wrapped.moveTo(x, y);
    return this;
  }

  /* move the turtle to a point and emit a new line */
  public function lineTo(x: Float, y: Float): DecoratedTurtle {
    wrapped.lineTo(x, y);
    return this;
  }

  private function get_position() { return wrapped.position; }
  private function set_position(v) { return wrapped.position = v; }
  private function get_lineWidth() { return wrapped.lineWidth; }
  private function set_lineWidth(w) { return wrapped.lineWidth = w; }
  private function get_color() { return wrapped.color; }
  private function set_color(c) { return wrapped.color = c; }
}
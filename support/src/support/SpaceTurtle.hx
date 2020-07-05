package support;

import support.linAlg2d.Space;

/**
    A Turtle which automatically transforms inputs using a space.
**/
class SpaceTurtle {
  private var turtle: Turtle;
  private var space: Space;

  public var lineWidth(get, set): Float;

  /* Create new turtle */
  public inline function new(view: Turtle.View, space: Space) {
    this.turtle = new Turtle(view);
    this.space = space;
  }

  /* Move the turtle to the point */
  public function moveTo(x: Float, y: Float): SpaceTurtle {
    turtle.moveTo(space.mapX(x), space.mapY(y));
    return this;
  }

  /* Draw a line from the turtle's current position to the point */
  public function lineTo(x: Float, y: Float): SpaceTurtle {
    turtle.lineTo(space.mapX(x), space.mapY(y));
    return this;
  }

  private function get_lineWidth() { return turtle.lineWidth; }
  private function set_lineWidth(v) { return turtle.lineWidth = v; }
}
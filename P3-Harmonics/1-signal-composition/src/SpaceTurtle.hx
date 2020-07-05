import support.Turtle;
import support.Turtle.View;

/**
    A Turtle which automatically transforms inputs using a space.
**/
class SpaceTurtle {
  private var turtle: Turtle;
  private var space: Space;

  public var lineWidth(default, default): Float;

  /* Create new turtle */
  public inline function new(view: View, space: Space) {
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

  function get_lineWidth() { return turtle.lineWidth; }
  function set_lineWidth(v) { return turtle.lineWidth = v; }
}
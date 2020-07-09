package support.turtle;

import support.color.Color;
import support.color.RGBA;
import support.linAlg2d.Line;
import support.linAlg2d.Vec;

/**
    A turtle implementation which 'renders' lines to an array.
    This allows tests to assert on which lines were emitted and the relevant
    settings.
**/
class ObservableTurtle implements Turtle {
  @:isVar public var position(get, set): Vec = new Vec(0, 0);
  @:isVar public var lineWidth(get, set): Float = 1.0;
  @:isVar public var color(get, set): Color = new RGBA();
  public var lines: Array<{line: Line, lineWidth: Float, color: Color}> = [];

  /* create a new instance with default values */
  public function new() {};

  /* move the turtle without emitting any geometry */
  public function moveTo(x, y): ObservableTurtle {
    position.x = x;
    position.y = y;
    return this;
  }

  /* emit a line to the lines buffer and update the turtle's position  */
  public function lineTo(x, y): ObservableTurtle {
    lines.push({
      line: new Line(position.clone(), new Vec(x, y)),
      lineWidth: lineWidth,
      color: color
    });
    moveTo(x, y);
    return this;
  }

  private function get_position() { return this.position; }
  private function set_position(p) { return this.position = p; }
  private function get_lineWidth() { return this.lineWidth; }
  private function set_lineWidth(w) { return this.lineWidth = w; }
  private function get_color() { return this.color; }
  private function set_color(c) { return this.color = c; }
}
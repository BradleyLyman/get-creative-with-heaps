package support.h2d;

import support.turtle.Turtle;
import support.linAlg2d.Vec;
import support.linAlg2d.Line;
import h3d.mat.Texture;

/**
    Objects of this type represent a collection of 2d lines on screen.

    FastLines renders each line as a Quad with vertices computed based on the
    line's width.

    There is no support for rounded edges or end caps. FastLines maintains all
    previously rendered lines until they are cleared.
**/
class FastLines extends h2d.Drawable {
  final quads : QuadsPrimitive;
  final white : Texture;

  /**
      Create a new instance of FastLines.

      @param parent
        an object in the scene which acts as the root for the fast lines
  **/
  public function new(parent: h2d.Object) {
    super(parent);
    this.quads = new QuadsPrimitive();
    this.white = Texture.fromColor(0xFFFFFF, 1.0);
  }

  /**
      Clear all lines from the display.
  **/
  public function clear() {
    quads.reset();
  }

  /**
      Add a line to the on screen display.

      Units are pixels and coordinates are influenced by the parent object's
      transform.
  **/
  public function addLine(line: Line, width: Float) {
    quads.push(line.toQuad(width));
  }

  /**
      Create a turtle which emits lines using this drawable.
      The turtle's coordinates are relative to this instance of FastLines.
  **/
  public function newTurtle(): Turtle {
    return new FastLinesTurtle(this);
  }

  /**
      Bind the white texture and render all quads.
  **/
  override function draw(ctx: h2d.RenderContext) {
    if (!ctx.beginDrawObject(this, white)) { return; }
    quads.render(ctx.engine);
  }
}

/**
    A Turtle implementation which renders lines using FastLines.
    Example:
        fastLines.newTurtle().moveTo(0, 0).lineTo(100, 100);
**/
private class FastLinesTurtle implements Turtle {
  /* the turtle's current position */
  @:isVar public var position(get, set): Vec = new Vec(0, 0);

  /* the line's width */
  @:isVar public var lineWidth(get, set): Float = 1.0;

  /* a reference to the fast lines which this turtle uses to emit geometry */
  private final fastLines: FastLines;

  public function new(fastLines: FastLines) {
    this.fastLines = fastLines;
  }

  /**
      Move the cursor to the specified position without emitting any geometry.
      @return FastLines this
  **/
  public function moveTo(x: Float, y: Float): FastLinesTurtle {
    this.position.x = x;
    this.position.y = y;
    return this;
  }

  /**
      Draw a line from the cunsor to the specified position.
      @return FastLinesTurtle this
  **/
  public function lineTo(x: Float, y: Float): FastLinesTurtle {
    this.fastLines.addLine(new Line(position, new Vec(x, y)), lineWidth);
    moveTo(x, y);
    return this;
  }

  private function get_position() { return this.position; }
  private function set_position(p) { return this.position = p; }
  private function get_lineWidth() { return this.lineWidth; }
  private function set_lineWidth(w) { return this.lineWidth = w; }
}

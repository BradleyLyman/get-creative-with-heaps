package support.h2d;

import support.color.Color;
import support.color.RGBA;
import support.h3d.prim.QuadsPrimitive;
import support.turtle.Turtle;
import support.linAlg2d.Vec;
import support.linAlg2d.Line;
import support.linAlg2d.Quad;
import h3d.mat.Texture;

/**
    Objects of this type represent a collection of drawable quads onscreen.
    Quads can be individually colored, but do not support texturing.
**/
class FastQuads extends h2d.Drawable {
  final quads : QuadsPrimitive;
  final white : Texture;

  /**
      Create a new instance of FastQuads.

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

  /* Add a new quad to the screen. */
  public function addQuad(quad: Quad, color: RGBA) {
    quads.push(quad, color);
  }

  /**
      Create a turtle which emits lines as thin quads.
      The turtle's coordinates are relative to this instance of FastQuads.
  **/
  public function newTurtle(): Turtle {
    return new FastQuadsTurtle(this);
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
    A Turtle implementation which renders lines using FastQuads.
    Coordinates are in screenspace (pixels) unless otherwise influenced by
    the parent fastquads instance.
    Example:
        fastQuads.newTurtle().moveTo(0, 0).lineTo(100, 100);
**/
private class FastQuadsTurtle implements Turtle {
  /* the turtle's current position */
  @:isVar public var position(get, set): Vec = new Vec(0, 0);

  /* the line's width */
  @:isVar public var lineWidth(get, set): Float = 1.0;

  /* the line's color */
  @:isVar public var color(get, set): Color = new RGBA();

  /* a reference to the fast lines which this turtle uses to emit geometry */
  private final fastQuads: FastQuads;

  public function new(fastQuads: FastQuads) {
    this.fastQuads = fastQuads;
  }

  /**
      Move the cursor to the specified position without emitting any geometry.
      @return FastQuads this
  **/
  public function moveTo(x: Float, y: Float): FastQuadsTurtle {
    this.position.x = x;
    this.position.y = y;
    return this;
  }

  /**
      Draw a line from the cunsor to the specified position.
      @return FastQuadsTurtle this
  **/
  public function lineTo(x: Float, y: Float): FastQuadsTurtle {
    lineToQuad(new Line(position, new Vec(x, y)));
    moveTo(x, y);
    return this;
  }

  /* Transform the line into a quad and render it onscreen */
  private function lineToQuad(line: Line) {
    fastQuads.addQuad(line.toQuad(lineWidth), color.toRGBA());
  }

  private function get_position() { return this.position; }
  private function set_position(p) { return this.position = p; }
  private function get_lineWidth() { return this.lineWidth; }
  private function set_lineWidth(w) { return this.lineWidth = w; }
  private function get_color() { return this.color; }
  private function set_color(c) { return this.color = c; }
}

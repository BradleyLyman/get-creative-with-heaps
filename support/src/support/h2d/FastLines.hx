package support.h2d;

import support.Turtle;
import support.linAlg2d.Line;
import h3d.mat.Texture;

/**
    Objects of this type represent a collection of 2d lines on screen.

    FastLines renders each line as a Quad with vertices computed based on the
    line's width.

    There is no support for rounded edges or end caps. FastLines maintains all
    previously rendered lines until they are cleared.
**/
class FastLines extends h2d.Drawable implements Turtle.View {
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
      Add a line to the on screen display.

      Units are pixels and coordinates are influenced by the parent object's
      transform.
  **/
  public function addLine(line: Line, width: Float) {
    quads.push(line.toQuad(width));
  }

  /**
      Clear all lines from the display.
  **/
  public function clear() {
    quads.reset();
  }

  /**
      Bind the white texture and render all quads.
  **/
  override function draw(ctx: h2d.RenderContext) {
    if (!ctx.beginDrawObject(this, white)) { return; }
    quads.render(ctx.engine);
  }
}

package support.h2d;

import hxd.Window;
import support.turtle.Turtle;
import support.color.Color;
import support.color.RGBA;
import support.linAlg2d.Quad;
import support.linAlg2d.Space;
import support.linAlg2d.Vec;
import support.turtle.SpaceTurtle;
import support.linAlg2d.Interval;

import h2d.Object;

/**
    Objects of this type represent a Space on screen which can be used for
    plotting graphics.
**/
class Plot extends Object {
  private final fastQuads: FastQuads;
  private final space: Space;

  /* The color of the plot's background quad */
  public var backgroundColor: Color = new RGBA(1, 1, 1, 0);

  /**
      A line-emitting turtle for this plot. Coordinates are in the x/y Axis for
      this plot.
  **/
  public final turtle: Turtle;

  /* The xAxis for this plot's input space */
  public var xAxis(get, set): Interval;

  /* The yAxis for this plot's input space */
  public var yAxis(get, set): Interval;

  /* The plot's width on screen. Call resize() to change */
  @:isVar public var width(default, null): Float;

  /* The plot's height on screen. Call resize() to change */
  @:isVar public var height(default, null): Float;

  /* Create a new plot with the provided parent. */
  public function new(parent: h2d.Object) {
    super(parent);
    this.fastQuads = new FastQuads(this);
    this.space = new Space();
    this.turtle = new SpaceTurtle(this.fastQuads.newTurtle(), this.space);
  }

  /* Clear everything from the plot and start clean */
  public function clear() {
    fastQuads.clear();
    fastQuads.addQuad(
      new Quad(
        new Vec(0, 0), new Vec(width, 0),
        new Vec(0, height), new Vec(width, height)
      ),
      backgroundColor.toRGBA()
    );
  }

  /**
      Draw a single quad to the screen.
      @param quad - the quad to draw, coordinates are relative to the x/y axis
      @param color - defaults to white
  **/
  public function drawQuad(quad: Quad, ?color: Color) {
    final transformed: Quad = new Quad(
      space.map(quad.topLeft), space.map(quad.topRight),
      space.map(quad.bottomLeft), space.map(quad.bottomRight)
    );
    if (color != null) {
      fastQuads.addQuad(transformed, color.toRGBA());
    }
    else {
      fastQuads.addQuad(transformed, new RGBA());
    }
  }

  /**
      The mouse's position with coords relative to the in the plot's X and Y
      axis.
      Assumes that the plot is not rotated or scaled using h2d.Object
      properties.
  **/
  public function mousePos(): Vec {
    final w = Window.getInstance();
    final mouse: Vec = [w.mouseX, w.mouseY];
    return space.invMap(mouse - [x, y]);
  }

  /**
      Resize the plot. Forces the contents to be cleared.
      @param width
      @param height
  **/
  public function resize(width: Float, height: Float) {
    this.width = width;
    this.height = height;
    space.xOut = new Interval(0, width);
    space.yOut = new Interval(height, 0);
    clear();
  }

  /**
      Override the bounds method on Object so that the plot plays nicely with
      the rest of Heaps.io 2d scene logic.
  **/
  override function getBoundsRec(
    relativeTo: Object,
    out: h2d.col.Bounds,
    forSize: Bool
  ) {
    super.getBoundsRec(relativeTo, out, forSize);
    addBounds(relativeTo, out, 0, 0, width, height);
  }

  private function get_xAxis() { return this.space.xIn; }
  private function set_xAxis(axis) { return this.space.xIn = axis; }
  private function get_yAxis() { return this.space.yIn; }
  private function set_yAxis(axis) { return this.space.yIn = axis; }
}
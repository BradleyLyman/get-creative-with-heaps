package support.h2d;

import support.linAlg2d.Space;
import support.turtle.SpaceTurtle;
import support.linAlg2d.Interval;

import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;

/**
    Objects of this type represent an onscreen Space.
**/
class Plot extends Object {
  private final fastQuads: FastQuads;
  private final background: Bitmap;
  private final space: Space;

  /**
      A line-emitting turtle for this plot. Coordinates are in the x/y Axis for
      this plot.
  **/
  public final turtle: SpaceTurtle;

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
    this.background = new Bitmap(Tile.fromColor(0xFFFFFF, 1, 1, 0.1), this);
    this.fastQuads = new FastQuads(this);
    this.space = new Space();
    this.turtle = new SpaceTurtle(this.fastQuads.newTurtle(), this.space);
  }

  /* Clear everything from the plot and start clean */
  public function clear() {
    fastQuads.clear();
  }

  /**
      Resize the plot. Forces the contents to be cleared.
      @param width
      @param height
  **/
  public function resize(width: Float, height: Float) {
    this.width = width;
    this.height = height;
    background.scaleX = width;
    background.scaleY = height;

    space.xOut = new Interval(0, width);
    space.yOut = new Interval(height, 0);

    clear();
  }

  private function get_xAxis() { return this.space.xIn; }
  private function set_xAxis(axis) { return this.space.xIn = axis; }
  private function get_yAxis() { return this.space.yIn; }
  private function set_yAxis(axis) { return this.space.yIn = axis; }
}
package support.h2d;

import support.linAlg2d.Space;
import support.turtle.SpaceTurtle;
import support.linAlg2d.Interval;

import hxd.fmt.hmd.Data.Position;
import h2d.Object;
import h2d.Graphics;
import h2d.Text;
import h2d.Bitmap;
import h2d.Tile;

/**
    Objects of this type represent an onscreen Space.
**/
class Plot extends Object {
  private final fastQuads: FastQuads;
  private final background: Bitmap;
  private final space: Space;

  public final turtle: SpaceTurtle;

  public var xAxis(get, set): Interval;
  public var yAxis(get, set): Interval;

  /* The plot's width on screen. Call resize() to change */
  @:isVar public var width(default, null): Float;

  /* The plot's height on screen. Call resize() to change */
  @:isVar public var height(default, null): Float;

  /**
      Create a new Plot object which can be used to present data on screen.
  **/
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

    fastQuads.clear();
  }

  private function get_lineWidth() { return this.turtle.lineWidth; }
  private function set_lineWidth(s) { return this.turtle.lineWidth = s; }
  private function get_xAxis() { return this.space.xIn; }
  private function set_xAxis(axis) { return this.space.xIn = axis; }
  private function get_yAxis() { return this.space.yIn; }
  private function set_yAxis(axis) { return this.space.yIn = axis; }
}
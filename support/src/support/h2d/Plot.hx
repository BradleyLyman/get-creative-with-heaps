package support.h2d;

import support.Turtle;
import support.linAlg2d.Space;
import support.linAlg2d.Interval;

import hxd.fmt.hmd.Data.Position;
import h2d.Object;
import h2d.Graphics;
import h2d.Text;
import h2d.Bitmap;
import h2d.Tile;

/**
    Objects of this class represent an onscreen cartesian plot.
**/
class Plot extends Object {
  private var fastLines: FastLines;
  private var background: Bitmap;

  private var turtle: SpaceTurtle;
  private var space: Space = new Space();
  private var margin: Float = 1/100;

  public var xAxis(get, set): Interval;
  public var yAxis(get, set): Interval;
  public var lineWidth(get, set): Float;

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
    this.fastLines = new FastLines(this);
    this.turtle = new SpaceTurtle(this.fastLines, this.space);
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

    final xMargin = width * margin;
    final yMargin = height * margin;
    final pxMargin = Math.max(xMargin, yMargin);
    space.xOut = new Interval(pxMargin, width-pxMargin);
    space.yOut = new Interval(height - pxMargin, pxMargin);

    fastLines.clear();
  }

  /**
      Plot f(x) for a sequence of connected points along the x axis.
      @param f - the function to plot
      @param subdivisions - the number of points to sample along teh x axis
  **/
  public function plotFunction(f: (Float) -> Float, subdivisions: Int = 500) {
    fastLines.clear();
    turtle.moveTo(space.xIn.min, f(space.xIn.min));
    for (x in space.xIn.subdivide(subdivisions)) {
      turtle.lineTo(x, f(x));
    }
  }

  private function get_lineWidth() { return this.turtle.lineWidth; }
  private function set_lineWidth(s) { return this.turtle.lineWidth = s; }
  private function get_xAxis() { return this.space.xIn; }
  private function set_xAxis(axis) { return this.space.xIn = axis; }
  private function get_yAxis() { return this.space.yIn; }
  private function set_yAxis(axis) { return this.space.yIn = axis; }
}
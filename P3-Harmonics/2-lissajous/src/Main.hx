import support.SpaceTurtle;
import support.h2d.FastLines;
import support.h2d.FullscreenButton;
import support.linAlg2d.Interval;
import support.linAlg2d.Space;
import support.linAlg2d.Vec;

using VectorPairIterator;

class Main extends hxd.App {
  final domain: Interval = new Interval(0, Math.PI*2);

  var lines: FastLines;
  var space: Space;
  var turtle: MaxLengthTurtle;
  var tvals: haxe.ds.Vector<Float>;
  var time: Float = 0.0;

  override function init() {
    lines = new FastLines(s2d);
    new FullscreenButton(s2d);
    space = new Space();
    turtle = new MaxLengthTurtle(new SpaceTurtle(lines, space), 0.5);
    turtle.lineWidth = 1;

    space.xIn = new Interval(-1, 1);
    space.yIn = new Interval(-1, 1);

    tvals = domain.subdivide(101);

    onResize();
  }

  override function onResize() {
    final side = Math.min(s2d.width, s2d.height) * 0.95;
    lines.x = (s2d.width - side) / 2.0;
    lines.y = (s2d.height - side) / 2.0;
    space.xOut = new Interval(0, side);
    space.yOut = new Interval(side, 0);
  }

  /**
      Plot each signal. Each plot's xAxis advances with time to give a view
      of how each signal changes with time.
  **/
  override function update(dt: Float) {
    final speed = 0.5 * (Math.PI / 4);
    time += dt*speed;
    final xSignal = (t: Float) -> Math.cos(t*2.1);
    final ySignal = (t: Float) -> Math.sin(t*1.3);

    lines.clear();
    for (i in tvals) {
      for (j in tvals) {
        turtle
          .moveTo(xSignal(i+time), ySignal(i+time))
          .lineTo(xSignal(j+time), ySignal(j+time));
      }
    }
  }

  static function main() { new Main(); }
}

class MaxLengthTurtle {
  final turtle: SpaceTurtle;
  final maxLength: Float;
  var cursor: Vec = Vec.of(0, 0);

  public var lineWidth(get, set): Float;

  public inline function new(turtle: SpaceTurtle, maxLength: Float) {
    this.turtle = turtle;
    this.maxLength = maxLength;
  }

  public inline function moveTo(x: Float, y: Float): MaxLengthTurtle {
    this.turtle.moveTo(x, y);
    this.cursor.x = x;
    this.cursor.y = y;
    return this;
  }

  public inline function lineTo(x: Float, y: Float) : MaxLengthTurtle {
    final dx = x - cursor.x;
    final dy = y - cursor.y;
    if (Math.sqrt(dx*dx + dy*dy) < maxLength) {
      this.turtle.lineTo(x, y);
    }
    else {
      this.turtle.moveTo(x, y);
    }
    this.cursor.x = x;
    this.cursor.y = y;
    return this;
  }

  public inline function get_lineWidth() { return turtle.lineWidth; }
  public inline function set_lineWidth(w) { return turtle.lineWidth = w; }
}
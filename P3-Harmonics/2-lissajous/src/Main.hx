import support.turtle.SpaceTurtle;
import support.h2d.FastLines;
import support.h2d.FullscreenButton;
import support.linAlg2d.Interval;

class Main extends hxd.App {
  final domain: Interval = new Interval(0, Math.PI*2);

  var lines: FastLines;
  var turtle: SpaceTurtle;
  var tvals: haxe.ds.Vector<Float>;
  var time: Float = 0.0;

  override function init() {
    lines = new FastLines(s2d);
    new FullscreenButton(s2d);
    turtle = new SpaceTurtle(lines.newTurtle());

    turtle.space.xIn = new Interval(-1, 1);
    turtle.space.yIn = new Interval(-1, 1);

    tvals = domain.subdivide(101);

    onResize();
  }

  override function onResize() {
    final side = Math.min(s2d.width, s2d.height) * 0.95;
    lines.x = (s2d.width - side) / 2.0;
    lines.y = (s2d.height - side) / 2.0;
    turtle.space.xOut = new Interval(0, side);
    turtle.space.yOut = new Interval(side, 0);
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
    final maxLenTurtle = new MaxLengthTurtle(turtle, 0.5);
    for (i in tvals) {
      for (j in tvals) {
        maxLenTurtle
          .moveTo(xSignal(i+time), ySignal(i+time))
          .lineTo(xSignal(j+time), ySignal(j+time));
      }
    }
  }

  static function main() { new Main(); }
}
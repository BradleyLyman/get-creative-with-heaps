import support.h2d.Plot;
import support.h2d.FullscreenButton;
import support.linAlg2d.Interval;

class Main extends hxd.App {
  final domain: Interval = new Interval(0, Math.PI*2);

  var plot: Plot;
  var tvals: haxe.ds.Vector<Float>;
  var time: Float = 0.0;

  override function init() {
    plot = new Plot(s2d);
    new FullscreenButton(s2d);

    plot.xAxis = new Interval(-1, 1);
    plot.yAxis = new Interval(-1, 1);
    tvals = domain.subdivide(101);

    onResize();
  }

  override function onResize() {
    final side = Math.min(s2d.width, s2d.height) * 0.95;
    plot.resize(side, side);
    plot.x = (s2d.width - side) / 2.0;
    plot.y = (s2d.height - side) / 2.0;
  }

  override function update(dt: Float) {
    final speed = 0.5 * (Math.PI / 4);
    time += dt*speed;
    final xSignal = (t: Float) -> Math.cos(t*2.1);
    final ySignal = (t: Float) -> Math.sin(t*1.3);

    plot.clear();
    final maxLenTurtle = new MaxLengthTurtle(plot.turtle, 0.5);
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
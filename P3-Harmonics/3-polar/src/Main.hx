import support.h2d.Plot;
import support.h2d.FullscreenButton;
import support.linAlg2d.Vec;
import support.linAlg2d.Interval;

class Main extends hxd.App {
  final domain:Interval = new Interval(0, Math.PI * 2);

  var plot:Plot;
  var tvals:haxe.ds.Vector<Float>;
  var time:Float = 0.0;

  override function init() {
    plot = new Plot(s2d);
    new FullscreenButton(s2d);

    plot.xAxis = new Interval(-1, 1);
    plot.yAxis = new Interval(-1, 1);
    plot.turtle.lineWidth = 2;
    tvals = domain.subdivide(501);

    onResize();
  }

  override function onResize() {
    final side = Math.min(s2d.width, s2d.height) * 0.95;
    plot.resize(side, side);
    plot.x = (s2d.width - side) / 2.0;
    plot.y = (s2d.height - side) / 2.0;
  }

  override function update(dt:Float) {
    final speed = 0.5 * (Math.PI / 4);
    time += dt * speed;
    final signal = (t:Float) -> {
      return 1 / 3.0 * (Math.cos(time + t)
        + Math.cos(time + t * 3)
        + Math.cos(time + t * 8));
    }

    final map = (t) -> {
      final angle = t;
      final radius = signal(t);
      return new Vec(Math.cos(angle) * radius, Math.sin(angle) * radius);
    };

    plot.clear();
    final s = map(tvals[0]);
    plot.turtle.moveTo(s.x, s.y);
    for (t in tvals) {
      final p = map(t);
      plot.turtle.lineTo(p.x, p.y);
    }
  }

  static function main() {
    new Main();
  }
}

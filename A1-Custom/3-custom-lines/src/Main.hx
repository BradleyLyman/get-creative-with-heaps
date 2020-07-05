import drawable.FastLines;

class Main extends hxd.App {
  var turtle : Turtle;
  var frames : RollingAverage;
  var time = 0.0;

  override function init() {
    new FullscreenButton(s2d);
    turtle = new Turtle(new FastLines(s2d));
    frames = new RollingAverage();

    turtle.lineWidth = 10;
  }

  override function update(dt: Float) {
    final start = haxe.Timer.stamp();
    timedUpdate(dt);
    final end = haxe.Timer.stamp();
    frames.push(end - start);
  }

  public function timedUpdate(dt) {
    time += dt;
    final count = Math.round(65000 / 4);
    turtle.lines.clear();
    for (i in 0...count) {
      final x = Math.random()*(s2d.width - 10);
      final y = (1.0 + Math.sin((time + x/s2d.width)*(Math.PI*2)))/2 * (s2d.height-10);
      turtle.moveTo(x, y).lineTo(x, y+1);
    }
  }

  static function main() {
    new Main();
  }
}

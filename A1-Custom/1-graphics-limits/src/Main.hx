import h2d.Graphics;

class Main extends hxd.App {

  var lines : Graphics;
  var frames = new RollingAverage();

  override function init() {
    lines = new Graphics(s2d);
    new FullscreenButton(s2d);
  }

  override function update(dt: Float) {
    final start = haxe.Timer.stamp();
    timedUpdate(dt);
    final end = haxe.Timer.stamp();
    frames.push(end - start);
  }

  private function timedUpdate(dt) {
    final count = 25000;
    lines.clear();
    //lines.beginFill(0, 0);
    lines.lineStyle(1, 0xFFFFFF, 1.0);
    for (i in 0...count) {
      final x = Math.random()*(s2d.width - 10);
      final y = (1.0 + Math.sin((x/s2d.width)*(Math.PI*2)))/2 * (s2d.height-10);
      lines.moveTo(x, y);
      lines.lineTo(x, y+1); // super tiny line so time isn't dependent on raster
    }
    //lines.endFill(); // turn on fill causes close to a 10% perf drop
  }

  static function main() {
    new Main();
  }
}

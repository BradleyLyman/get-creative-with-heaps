import h2d.Tile;
import support.color.RGBA;
import hxd.Pixels;
import h2d.Bitmap;
import support.color.HSL;
import support.linAlg2d.Interval;
import support.linAlg2d.Vec;
import hxd.Res;
import h2d.Interactive;
import support.h2d.Plot;

using support.turtle.VecTurtle;

class Main extends hxd.App {
  var plot:Plot;
  var plotInteractive:Interactive;
  var noise:PerlinNoise = new PerlinNoise();
  var bitmap:Bitmap;

  override function init() {
    plot = new Plot(s2d);
    plot.turtle.lineWidth = 2;
    plot.xAxis = new Interval(-0.5, 1.5);
    plot.yAxis = new Interval(-0.5, 1.5);
    plotInteractive = new Interactive(1, 1, plot);

    new support.h2d.FullscreenButton(s2d);

    bitmap = new Bitmap(Tile.fromPixels(noisePixels(512)), s2d);

    onResize();
  }

  private function noisePixels(size:Int):Pixels {
    final p = Pixels.alloc(size, size, ARGB);
    for (x in 0...size) {
      for (y in 0...size) {
        final v:Vec = [x, y];
        final i = Math.abs(noise.noise(v * (16.0 / size)));
        final c = new RGBA(i, i, i);
        p.setPixel(x, y, c.toARGBInt());
      }
    }
    return p;
  }

  override function onResize() {
    final size = Math.min(s2d.width, s2d.height);
    plot.resize(size, size);
    plotInteractive.width = plotInteractive.height = size;
    plot.x = (s2d.width - size) / 2;
    plot.y = (s2d.height - size) / 2;

    plot.clear();
  }

  override function update(dt:Float) {
    plot.clear();
    drawGrid();
  }

  private function drawGrid() {
    final turtle = plot.turtle;

    turtle.moveTo(0, 0);
    final y = 0.5;
    for (x in plot.xAxis.subdivide(200)) {
      turtle.lineTo(x, y + noise.noise([x * 3, y]));
    }
  }

  private function lerp(t:Float, start:Float, end:Float) {
    return (1.0 - t) * start + t * end;
  }

  private function dot(a:Vec, b:Vec):Float {
    return a.x * b.x + a.y * b.y;
  }

  private function drawCircleAt(p:Vec, radius:Float = 0.1) {
    plot.turtle.lineWidth = 3;
    final start = p + Vec.ofPolar(0, radius);
    final segments = 32;
    plot.turtle.moveToVec(start);
    for (i in 1...segments) {
      final offset = Vec.ofPolar(i / segments * Math.PI * 2, radius);
      plot.turtle.lineToVec(p + offset);
    }
    plot.turtle.lineToVec(start);
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}

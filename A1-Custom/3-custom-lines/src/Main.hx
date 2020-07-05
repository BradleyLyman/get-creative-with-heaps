import h2d.Interactive;
import format.abc.Data.ABCData;
import h2d.col.Point;
import h2d.Graphics;
import hxsl.ShaderList;
import h3d.mat.MaterialSetup;
import h3d.scene.Mesh;
import h3d.prim.Cube;
import h3d.mat.Texture;

import drawable.FastLines;

class Turtle {
  public final lines : FastLines;

  public var lineWidth : Float = 1;
  public var position : Vec2 = new Vec2(0, 0);

  public inline function new(lines: FastLines) {
    this.lines = lines;
  }

  public inline function moveTo(x: Float, y: Float): Turtle {
    position.x = x;
    position.y = y;
    return this;
  }

  public inline function lineTo(x: Float, y: Float): Turtle {
    final to = new Vec2(x, y);
    lines.addLine(new Line(position, to), lineWidth);
    this.position = to;
    return this;
  }
}

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

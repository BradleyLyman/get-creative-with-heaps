/**
  An implementation of perlin noise.
**/

import support.turtle.Turtle;
import support.linAlg2d.Vec;

using support.turtle.VecTurtle;

class PerlinNoise {
  private final gridSize:Int;
  private final points:haxe.ds.Vector<Vec>;
  private final rng:() -> Float;

  public function new(gridSize:Int = 64, ?rng:() -> Float) {
    this.gridSize = gridSize;
    this.rng = rng != null ? rng : mathRandom;
    this.points = new haxe.ds.Vector<Vec>(gridSize * gridSize);

    regeneratePoints();
  }

  public function noise(p:Vec):Float {
    final at:Vec = toGridSpace(p);
    final snapped:Vec = [Math.floor(at.x), Math.floor(at.y)];
    final corners = [
      snapped, // bottom left
      snapped + [1, 0], // bottom right
      snapped + [0, 1], // top left
      snapped + [1, 1] // top right
    ];
    final dots = [
      for (c in corners) {
        final d = (at - c);
        final g = gradientAt(c);
        dot(g, d);
      }
    ];
    final interp = at - snapped;
    final bot = lerp(interp.x, dots[0], dots[1]);
    final top = lerp(interp.x, dots[2], dots[3]);
    return lerp(interp.y, bot, top);
  }

  private function dot(a:Vec, b:Vec):Float {
    return a.x * b.x + a.y * b.y;
  }

  private function lerp(t:Float, start:Float, end:Float):Float {
    return (1.0 - t) * start + t * end;
  }

  public function gradientAt(p:Vec):Vec {
    final xInd = Math.round(p.x % gridSize);
    final yInd = Math.round(p.y % gridSize);
    return points[xInd + gridSize * yInd];
  }

  public function gradient(x:Int, y:Int):Vec {
    final xInd = Math.round(x % gridSize);
    final yInd = Math.round(y % gridSize);
    return points[xInd + gridSize * yInd];
  }

  /* Snap a p float value to an integer grid cell */
  public function snap(a:Float):Int {
    final abs = Math.abs(a); // reflect around the origin
    return Math.floor(abs); // modulate to a point in the grid
  }

  public function toGridSpace(a:Vec):Vec {
    return [Math.abs(a.x) % gridSize, Math.abs(a.y) % gridSize];
  }

  private function regeneratePoints() {
    for (i in 0...points.length) {
      points[i] = Vec.of(rng(), rng()).norm();
    }
  }

  private function mathRandom():Float {
    final t = Math.random();
    return lerp(t, -1, 1);
  }
}

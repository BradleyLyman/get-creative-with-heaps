import h2d.Graphics;
import hxd.Window;

/**
  Objects of this type represent an intelligent agent which follows the
  mouse.

  The agent maintains a ring of vertices which initially form a circle around
  the center point. The center point will move to follow the mouse while the
  points in the circle will jitter randomly.
**/
class Agent {
  private var center:Vector;
  private var vertices:Array<Vector>;

  private final window:Window;
  private final speed:Float;
  private final radius:Float;

  public function new(
    center:Vector,
    divisions = 8,
    radius:Float = 100,
    speed:Float = 100
  ) {
    window = Window.getInstance();
    this.center = center;
    this.speed = speed;
    this.radius = radius;

    vertices = [
      for (i in 0...divisions) {
        final normed = i / divisions;
        final angle = normed * Math.PI * 2;
        [Math.cos(angle) * radius, Math.sin(angle) * radius];
      }
    ];
  }

  public function step(dt:Float) {
    final attractor:Vector = [window.mouseX, window.mouseY];
    final span = (attractor - center);
    final direction = span.normalized();

    center = center + direction * dt * speed;

    vertices = vertices.map(v -> {
      final velocity = jitter() * dt * radius;
      return v + velocity;
    });
  }

  function jitter():Vector {
    final angle = Math.random() * Math.PI * 2;
    final len = 0.2;
    return [Math.cos(angle) * len, Math.sin(angle) * len];
  }

  public function render(graphics:Graphics) {
    final hue = Math.PI * 2 * (center.x / window.width);
    graphics.lineStyle(2.0, colorFor(hue, 0.8), 0.5);
    graphics.beginFill(colorFor(hue + Math.PI, 0.5), 0.1);
    graphics.moveTo(vertices[0].x + center.x, vertices[0].y + center.y);
    for (i in 1...vertices.length) {
      graphics.lineTo(vertices[i].x + center.x, vertices[i].y + center.y);
    }
    graphics.lineTo(vertices[0].x + center.x, vertices[0].y + center.y);
    graphics.endFill();
  }

  private function colorFor(
    hue:Float,
    saturation:Float = 0.8,
    lightness:Float = 0.5
  ):Int {
    final vec = new h3d.Vector();
    vec.makeColor(hue, saturation, lightness);
    return vec.toColor();
  }
}

import hxd.Window.DisplayMode;
import h2d.Interactive;
import hxd.Key;
import h2d.Scene.ScaleMode;
import h2d.Scene.ScaleModeAlign;

class Main extends hxd.App {

  var graphics : h2d.Graphics;

  /* The size, in pixels, for each grid cell. */
  var gridSize : Int = 100;

  var agents : Array<Agent> = [];

  override function init() {
    new FullscreenButton(s2d);
    graphics = new h2d.Graphics(s2d);
    hxd.Window.getInstance().addEventTarget(onEvent);

    agents = [
      for (i in 0...10) {
        new Agent(
          Math.random() * s2d.width,
          Math.random() * s2d.height,
          s2d.width,
          s2d.height
        );
      }
    ];
  }

  function onEvent(event: hxd.Event) {
    switch (event.kind) {
      case ERelease:
        onResize();
      case EKeyUp:
      default: // do nothing
    }
  }

  override function onResize() {
    for (agent in agents) {
      agent.onResize(s2d.width, s2d.height);
    }
  }

  override function update(dt: Float) {
    graphics.clear();

    Agent.renderLines(graphics, s2d.width);

    for (agent in agents) {
      agent.step(300 * dt);
      agent.render(graphics);
    }
  }

  private function lerp(x: Float, start: Float, end: Float) : Float {
      return x*(end - start) + start;
  }

  private function colorFor(
      hue: Float,
      saturation: Float = 0.8,
      lightness: Float = 0.5
  ) : Int {
      final vec = new h3d.Vector();
      vec.makeColor(hue, saturation, lightness);
      return vec.toColor();
  }

  static function main() {
      new Main();
  }
}
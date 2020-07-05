
class Main extends hxd.App {

  var agents : Array<Agent> = [];
  var preview : h2d.Graphics;
  var canvas : Canvas;

  override function init() {
    canvas = new Canvas(s2d);
    preview = new h2d.Graphics(s2d);
    new support.h2d.FullscreenButton(s2d);
    resetAgents();
    hxd.Window.getInstance().addEventTarget(onEvent);
  }

  override function onResize() {
    resetAgents();
  }

  function onEvent(e: hxd.Event) {
    switch (e.kind) {
      case ERelease: resetAgents();
      case EKeyUp: preview.visible = !preview.visible;
      default: //
    }
  }

  function resetAgents() {
    agents = [
      for (i in 0...60) {
        new Agent(colorFor(Math.PI*2*Math.random(), 0.5));
      }
    ];
  }

  override function update(dt: Float) {
    preview.clear();
    for (agent in agents) {
      agent.step(300 * dt, canvas.graphics, canvas.currentPixels());
      agent.render(preview);
    }

    canvas.update();
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
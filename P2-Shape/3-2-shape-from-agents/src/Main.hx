
class Main extends hxd.App {

  var agent : Agent;
  var canvas : Canvas;

  override function init() {
    canvas = new Canvas(s2d);
    new FullscreenButton(s2d);
    resetAgent();
  }

  override function onResize() {
    resetAgent();
  }

  function resetAgent() {
    agent = new Agent(
      [s2d.width/2, s2d.height/2],
      100,
      s2d.width/15,
      s2d.width/3
    );
  }

  override function update(dt: Float) {
    agent.step(dt);
    agent.render(canvas.graphics);
    canvas.update();
  }

  static function main() {
      new Main();
  }
}
class Main extends hxd.App {

  /* Used for drawing 2d shapes on screen. */
  var graphics : h2d.Graphics;

  var time : Float = 0;

  var pressed : Bool = false;
  var lastPos : Array<Float> = [0, 0];
  var currentPos: Array<Float> = [0, 0];

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
      graphics = new h2d.Graphics(s2d);
      hxd.Window.getInstance().addEventTarget(onEvent);
      new FullscreenButton(s2d);
  }

  function onEvent(e: hxd.Event) {
    switch (e.kind) {
      case EPush: pressed = true;
      case ERelease: pressed = false;
      case EMove:
      default: // nothing
    }
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
    time += dt;
    if (pressed) {
      graphics.lineStyle(8, colorFor(time), 1.0);
      graphics.moveTo(lastPos[0], lastPos[1]);
      graphics.lineTo(currentPos[0], currentPos[1]);
      lastPos = currentPos;
      currentPos = [s2d.mouseX, s2d.mouseY];
    }
    else {
      lastPos = [s2d.mouseX, s2d.mouseY];
      currentPos = [s2d.mouseX, s2d.mouseY];
    }
  }

  /**
      A function which transforms a color represented as hue, saturation,
      and brightness to a packed 32-bit RGB Int.
  **/
  private function colorFor(
      hue: Float,
      saturation: Float = 0.8,
      brightness: Float = 0.5
  ) : Int {
    final vec = new h3d.Vector();
    vec.makeColor(hue, saturation, brightness);
    return vec.toColor();
  }

  static function main() {
    new Main();
  }
}
import h3d.mat.Texture;
import h3d.mat.Data.TextureFormat;
import h2d.Tile;
import h2d.Bitmap;

class Main extends hxd.App {
  var time = 0.0;

  /* Used for drawing 2d shapes on screen. */
  var graphics : h2d.Graphics;
  var canvas : Canvas;

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
    canvas = new Canvas(s2d);
    new support.h2d.FullscreenButton(s2d);

    // attach the graphics to the *canvas* scene instead of the application
    // scene
    graphics = new h2d.Graphics(canvas.s2d);
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
    time += dt;

    graphics.clear();
    graphics.beginFill(colorFor(time), 0.5);
    graphics.drawCircle(
      s2d.mouseX, s2d.mouseY, 10 + (s2d.mouseX / s2d.width) * 90, 80
    );
    graphics.endFill();

    // update the canvas's contents
    canvas.update();
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
import support.linAlg2d.Quad;
import support.color.HSL;
import support.h2d.FastQuads;

class Main extends hxd.App {

  /* How much of the screen should the foreground rectange occupy */
  var sizeRatio : Float;

  /* The foreground and background colors */
  var foreground : HSL;
  var background : HSL;

  /* A graphical primitive which renders quads onscreen very quickly. */
  var quads : FastQuads;

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
    foreground = new HSL(0, 0.75, 0.65);
    background = new HSL(0, 0.75, 0.35);
    quads = new FastQuads(s2d);
    new support.h2d.FullscreenButton(s2d);
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
    // The size ratio is controlled by the mouse's X position
    sizeRatio = Math.abs((s2d.mouseX * 2 / s2d.width) - 1.0);

    // The hue is controlled by the mouse's Y position
    final normalized_y = s2d.mouseY / s2d.height;
    foreground.hue = normalized_y * 360;
    background.hue = foreground.hue + 180;

    // Remove the last update's rectangles
    quads.clear();

    // draw the background first
    drawBackground();

    // then the foreground
    drawForeground();
  }

  /**
      The background is a rectangle which fills the entire screen.
  **/
  private function drawBackground() {
    quads.addQuad(
      Quad.aligned(0, 0, s2d.height, s2d.width),
      background.toRGBA()
    );
  }

  /**
      The foreground is a rectangle which fills a section of the screen
      controlled b ythe mouse.
      The emptyRatio and sizeRatio are used to center the rectangle.
  **/
  private function drawForeground() {
      final width = s2d.width * sizeRatio;
      final height = s2d.height * sizeRatio;
      final top = (s2d.height - height) / 2;
      final left = (s2d.width - width) / 2;
      quads.addQuad(
        Quad.aligned(top, left, top + height, left + width),
        foreground.toRGBA()
      );
  }

  static function main() {
      new Main();
  }
}
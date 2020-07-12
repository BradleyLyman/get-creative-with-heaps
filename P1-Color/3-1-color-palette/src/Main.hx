import support.linAlg2d.Quad;
import support.color.HSL;
import support.h2d.FastQuads;

class Main extends hxd.App {

  var quads : FastQuads;

  /** The number of steps used to render the gradient's transition */
  var gradientSteps : Int = 3;

  /** The colors on the left and right sides of the screen */
  var colors : Array<{left: HSL, right: HSL}> = new Array();

  override function init() {
    quads = new FastQuads(s2d);
    new support.h2d.FullscreenButton(s2d);
    hxd.Window.getInstance().addEventTarget(handleClick);
    pickColors();
  }

  /* Handle mouse events, everything else is ignored */
  function handleClick(event: hxd.Event) {
    if (event.kind == EPush) { pickColors(); }
  }

  override function update(dt: Float) {
    updateSteps(s2d.mouseX);
    drawPaletteGrid();
  }

  /* Use the mouse coordinates to control the number of rows */
  private function updateSteps(mouseX: Float) {
    final normalized = { x: mouseX / s2d.width };
    // the number of steps can range from [3, 50]
    gradientSteps = 3 + Math.floor(normalized.x * 47);
  }

  /* Generate new colors for the left and right sides of the screen. */
  private function pickColors() {
    colors = [
      for (i in 0...10)
      {
        left: new HSL(
          Math.random() * 180,
          Math.random(),
          (Math.random() * 0.5 + 0.25)
        ),
        right: new HSL(
          (Math.random() * 180) + 180,
          Math.random(),
          (Math.random() * 0.5 + 0.25)
        )
      }
    ];
  }

  /**
      Draw the color palettes as a grid of colored panels. The HSL values
      are linearly interpolated based on the column index.
  **/
  private function drawPaletteGrid() {
    final width = s2d.width / gradientSteps;
    final height = s2d.height / colors.length;

    quads.clear();

    for (col in 0...gradientSteps) {
      for (row in 0...colors.length) {
        final top = row * height;
        final left = col * width;

        quads.addQuad(
          Quad.aligned(top, left, top + height, left + width),
          lerp(col/gradientSteps, colors[row].left, colors[row].right).toRGBA()
        );
      }
    }
  }

  /**
      The magic of this demo! Linearly interpolate between two HSL colors.
      @param x - the controling variable, should be in the range [0, 1]
      @param start - the color when x == 0
      @param end - the color when x == 1
  **/
  private function lerp(x: Float, start: HSL, end: HSL) : HSL {
    return new HSL(
      x*(end.hue - start.hue) + start.hue,
      x*(end.saturation - start.saturation) + start.saturation,
      x*(end.lightness - start.lightness) + start.lightness
    );
  }

  static function main() { new Main(); }
}
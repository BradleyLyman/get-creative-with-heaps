import support.linAlg2d.Quad;
import support.color.HSL;
import support.h2d.FastQuads;

class Main extends hxd.App {
  /* Quickly draw a lot of quads on screen */
  var quads:FastQuads;

  /* How many rows and columns to divide the screen into. */
  var columnCount:Int = 3;
  var rowCount:Int = 3;

  /* Initialize the demo. Called automatically by Heaps. */
  override function init() {
    quads = new FastQuads(s2d);
    new support.h2d.FullscreenButton(s2d);
  }

  /* Update the screen. Called before each frame. */
  override function update(dt:Float) {
    quads.clear();
    updateSteps();
    drawSpectrumGrid();
  }

  /**
    Use the mouse coordinates to calculate new horizontal and vertical
    step values. These are used to divide the screen into rows and columns.
  **/
  private function updateSteps() {
    final normalized = {
      x: s2d.mouseX / s2d.width,
      y: s2d.mouseY / s2d.height
    };

    // the number of columns can range from [3, 360]
    columnCount = 3 + Math.floor(normalized.x * 357);

    // the number of rows can range from [3, 100]
    rowCount = 3 + Math.floor(normalized.y * 97);
  }

  /**
    Draw the spectrum grid by dividing the screen into rows and colums.
    Each column is a different hue. Each row is a different value, aka
    brightness.
  **/
  private function drawSpectrumGrid() {
    final width = s2d.width / columnCount;
    final height = s2d.height / rowCount;

    for (x in 0...columnCount) {
      for (y in 0...rowCount) {
        // map the x and y coordinates into the range [0, 1]
        final normalized_x = x / columnCount;
        final normalized_y = y / rowCount;

        // map the normalized coordinates into screen coordinates
        // aka pixels
        final left = normalized_x * s2d.width;
        final top = normalized_y * s2d.height;

        // map the normalized coord from [0, 1] to [0, 360]
        final hue = normalized_x * 360;

        // map the normalized coord from [0, 1] to [0, 1]
        // But, select the value from the midpoint of the rectangle,
        // instead of the top edge. (it looks better)
        final midpoint_step = 0.5 / rowCount;
        final value = normalized_y + midpoint_step;

        quads.addQuad(
          Quad.aligned(top, left, top + height, left + width),
          new HSL(hue, 0.8, value).toRGBA()
        );
      }
    }
  }

  static function main() {
    new Main();
  }
}

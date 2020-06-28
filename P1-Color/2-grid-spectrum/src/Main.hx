class Main extends hxd.App {

    /* Used for drawing 2d shapes on screen. */
    var graphics : h2d.Graphics;

    /* A reference to the main window, used to get the mouse position. */
    var window : hxd.Window;

    /* How many rows and columns to divide the screen into. */
    var columnCount : Int = 3;
    var rowCount : Int = 3;

    /* Initialize the demo. Called automatically by Heaps. */
    override function init() {
        graphics = new h2d.Graphics(s2d);
        window = hxd.Window.getInstance();
        new FullscreenButton(s2d);
    }

    /* Update the screen. Called before each frame. */
    override function update(dt: Float) {
        graphics.clear(); // clear the grid from the previous frame
        updateSteps();
        drawSpectrumGrid();
    }

    /**
        Use the mouse coordinates to calculate new horizontal and vertical
        step values. These are used to divide the screen into rows and columns.
    **/
    private function updateSteps() {
        final normalized = {
            x: window.mouseX / s2d.width,
            y: window.mouseY / s2d.height
        };

        // the number of columns can range from [3, 50]
        columnCount = 3 + Math.floor(normalized.x * 47);

        // the number of rows can range from [3, 20]
        rowCount = 3 + Math.floor(normalized.y * 17);
    }

    /**
        Draw the spectrum grid by dividing the screen into rows and colums.
        Each column is a different hue. Each row is a different value, aka
        brightness.
    **/
    private function drawSpectrumGrid() {
        // compute the position and color for each rectangle in the grid
        final grid = [
            for (x in 0...columnCount) {
                for (y in 0...rowCount) {
                    // map the x and y coordinates into the range [0, 1]
                    final normalized_x = x / columnCount;
                    final normalized_y = y / rowCount;

                    // map the normalized coordinates into screen coordinates
                    // aka pixels
                    final left_position = normalized_x * s2d.width;
                    final top_position = normalized_y * s2d.height;

                    // map the normalized coord from [0, 1] to [0, TWO_PI]
                    final hue =  normalized_x * (Math.PI*2);

                    // map the normalized coord from [0, 1] to [0, 1]
                    // But, select the value from the midpoint of the rectangle,
                    // instead of the top edge. (it looks better)
                    final midpoint_step = 0.5 / rowCount;
                    final value = normalized_y + midpoint_step;

                    // emit the actual rectangle
                    {
                        left: left_position,
                        top: top_position,
                        hue: hue,
                        value: value
                    };
                }
            }
        ];

        final width = s2d.width / columnCount;
        final height = s2d.height / rowCount;

        // draw each rectangle in the grid
        for (rect in grid) {
            graphics.beginFill(colorFor(rect.hue, 0.8, rect.value));
            graphics.drawRect(rect.left, rect.top, width, height);
            graphics.endFill();
        }
    }

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
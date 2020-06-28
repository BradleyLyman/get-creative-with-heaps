typedef HSL = { h: Float, s: Float, l: Float };

class Main extends hxd.App {

    /** graphics enables arbitrary 2-d geometry rendering */
    var graphics : h2d.Graphics;

    /** The number of steps used to render the gradient's transition */
    var gradientSteps : Int = 3;

    /** The colors on the left and right sides of the screen */
    var colors : Array<{left: HSL, right: HSL}> = new Array();

    override function init() {
        graphics = new h2d.Graphics(s2d);
        new FullscreenButton(s2d);
        hxd.Window.getInstance().addEventTarget(onEvent);
        pickColors();
    }

    function onEvent(event: hxd.Event) {
        switch(event.kind) {
            case EMove:
                updateSteps(event.relX);
                drawPaletteGrid();
            case EPush:
                pickColors();
                updateSteps(event.relX);
                drawPaletteGrid();
            default: // ignore other event types
        }
    }

    /**
        Use the mouse coordinates to control the number of rows
    **/
    private function updateSteps(mouseX: Float) {
        final normalized = { x: mouseX / s2d.width };
        // the number of steps can range from [3, 15]
        gradientSteps = 3 + Math.floor(normalized.x * 12);
    }

    /**
        Randomly generate new colors for the left and right sides of the screen.
    **/
    private function pickColors() {
        colors = [
            for (i in 0...10)
            {
                left: {
                    h: Math.random() * Math.PI,
                    s: Math.random(),
                    l: (Math.random() * 0.5 + 0.25)
                },
                right: {
                    h: (Math.random() * Math.PI) + Math.PI,
                    s: Math.random(),
                    l: (Math.random() * 0.5 + 0.25)
                }
            }
        ];
    }

    /**
        Draw the color palettes as a grid of colored panels. The HSL values
        are linearly interpolated based on the X coordinate of the left side
        of the panel.
    **/
    private function drawPaletteGrid() {
        // rename because it's easier to reason about rows and columns
        final columnCount = gradientSteps;
        final rowCount = colors.length;

        // compute the position and color for each rectangle in the grid
        final grid = [
            for (x in 0...columnCount) {
                for (row in 0...rowCount) {
                    // map the x and y coordinates into the range [0, 1]
                    final norm_x = x / columnCount;
                    final norm_y = row / rowCount;

                    // emit the actual rectangle
                    {
                        left: norm_x * s2d.width,
                        top: norm_y * s2d.height,
                        color: lerp(norm_x, colors[row].left, colors[row].right)
                    }
                }
            }
        ];

        final width = s2d.width / columnCount;
        final height = s2d.height / rowCount;

        // clear the graphics so old rectangles don't accumulate
        graphics.clear();
        for (rect in grid) {
            graphics.beginFill(colorIntFor(rect.color));
            graphics.drawRect(rect.left, rect.top, width, height);
            graphics.endFill();
        }
    }

    /**
        The magic of this demo! Linearly interpolate between two HSL colors.
        @param x - the controling variable, should be in the range [0, 1]
        @param start - the color when x == 0
        @param end - the color when x == 1
    **/
    private function lerp(x: Float, start: HSL, end: HSL) : HSL {
        return {
            h: x*(end.h - start.h) + start.h,
            s: x*(end.s - start.s) + start.s,
            l: x*(end.l - start.l) + start.l
        };
    }

    private function colorIntFor(color: HSL) : Int {
        final vec = new h3d.Vector();
        vec.makeColor(color.h, color.s, color.l);
        return vec.toColor();
    }

    static function main() {
        new Main();
    }
}
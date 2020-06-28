class Main extends hxd.App {

    /* Used for drawing 2d shapes on screen. */
    var graphics : h2d.Graphics;

    /* How much of the screen should the foreground rectange occupy */
    var sizeRatio : Float;

    /* The foreground hue. The H in HSL for the foreground color */
    var foregroundHue : Float;

    /* A reference to the main window, used to get the mouse position. */
    var window : hxd.Window;

    /**
        Initialize the demo. This is automatically called by Heaps when
        the window is ready.
    **/
    override function init() {
        graphics = new h2d.Graphics(s2d);
        window = hxd.Window.getInstance();
        new FullscreenButton(s2d);
    }

    /**
        Update the contents of the screen.
        This is automatically called by Heaps before each frame.
    **/
    override function update(dt: Float) {
        // The size ratio is controlled by the mouse's X position
        sizeRatio = Math.abs((window.mouseX * 2 / s2d.width) - 1.0);

        // The hue is controlled by the mouse's Y position
        final normalized_y = window.mouseY / s2d.height;
        foregroundHue = normalized_y * (Math.PI * 2);

        // Lines and rectangles will accumulate in the graphics object unless
        // it's cleared.
        graphics.clear();

        // draw the background first
        drawBackground();

        // then the foreground
        drawForeground();
    }

    /**
        The background is a rectangle which fills the entire screen.
        The hue is offset by Math.PI to select a color on the opposite side
        of the color wheel from the foreground rectangle.
    **/
    private function drawBackground() {
        // The background uses the inverted hue
        graphics.beginFill(colorFor(foregroundHue - Math.PI));
        graphics.drawRect(0, 0, s2d.width, s2d.height);
        graphics.endFill();
    }

    /**
        The foreground is a rectangle which fills a section of the screen
        controlled b ythe mouse.
        The emptyRatio and sizeRatio are used to center the rectangle.
    **/
    private function drawForeground() {
        final emptyRatio = 1.0 - sizeRatio;
        final borderWidth = emptyRatio / 2.0;
        graphics.beginFill(colorFor(foregroundHue));
        graphics.drawRect(
            s2d.width * borderWidth,
            s2d.height * borderWidth,
            s2d.width * sizeRatio,
            s2d.height * sizeRatio
        );
        graphics.endFill();
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
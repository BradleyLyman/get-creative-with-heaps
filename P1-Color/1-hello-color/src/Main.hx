class Main extends hxd.App {

    /**
     * Graphics is used for immediate-mode 2d rendering.
     */
    var graphics : h2d.Graphics;

    /**
     * How much of the screen should the foreground rectangle occupy.
     */
    var sizeRatio : Float;

    /**
     * The foreground hue.
     */
    var foregroundHue : Float;

    /**
     * A reference to the main window. Useful for quickly checking the mouse
     * position.
     */
    var window : hxd.Window;


    override function init() {
        graphics = new h2d.Graphics(s2d);
        window = hxd.Window.getInstance();
    }

    override function update(dt: Float) {
        // The size ratio is controlled by the mouse's X position
        sizeRatio = Math.abs((window.mouseX * 2 / s2d.width) - 1.0);

        // The hue is controlled by the mouse's Y position
        final normalized_y = window.mouseY / s2d.height;
        foregroundHue = normalized_y * (Math.PI * 2);

        graphics.clear();
        drawBackground();
        drawForeground();
    }
    private function drawBackground() {
        // The background uses the inverted hue
        graphics.beginFill(colorFor(foregroundHue - Math.PI));
        graphics.drawRect(0, 0, s2d.width, s2d.height);
        graphics.endFill();
    }

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
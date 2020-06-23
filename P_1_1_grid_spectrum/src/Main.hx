class Main extends hxd.App {

    /**
     * Graphics is used for immediate-mode 2d rendering.
     */
    var graphics : h2d.Graphics;

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
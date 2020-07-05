import hxd.Key;
import h3d.Vector;
import haxe.io.Bytes;
import h2d.Object;

using PixelTools;

class Main extends hxd.App {

    /** A collection of image data which can be used onscreen **/
    var images : Array<hxd.Pixels>;

    /** The index into images[] for the currently displayed picture */
    var imageIndex : Int;

    /** A graphical object which knows how to paint bitmap data */
    var displayed : h2d.Bitmap;

    override function init() {
        imageIndex = 0;
        images = [
            hxd.Res.landscape1.toBitmap().getPixels(),
            hxd.Res.landscape2.toBitmap().getPixels(),
            hxd.Res.landscape3.toBitmap().getPixels(),
        ];
        displayed = new h2d.Bitmap(h2d.Tile.fromPixels(images[0]), s2d);

        hxd.Window.getInstance().addEventTarget(onEvent);
        onResize();

        new support.h2d.FullscreenButton(s2d);
    }

    /**
        Handle Window events.
        When the mouse is clicked show the next image in our list.
        When a number key is pressed, replace the pixels according to a sort
        operation.
    **/
    function onEvent(event: hxd.Event) {
        switch (event.kind) {
            case ERelease: // do nothing
                showNextImage();
            case EKeyUp:
                onCharUp(event.keyCode);
            default: // do nothing
        }
    }

    /**
        Handle a number key release.
    **/
    function onCharUp(code: Int) {
        final newPixels : hxd.Pixels = switch (code) {
                case Key.NUMBER_1:
                    images[imageIndex].toSorted(orderByHue);
                case Key.NUMBER_2:
                    images[imageIndex].toSorted(orderBySaturation);
                case Key.NUMBER_3:
                    images[imageIndex].toSorted(orderByLightness);
                default: images[imageIndex];
            };
        displayed.tile = h2d.Tile.fromPixels(newPixels);
    }

    /**
        Update the current image index. If it's too big, wrap around to the
        first image again.
    **/
    function showNextImage() {
        imageIndex += 1;
        if (imageIndex >= images.length) {
            imageIndex = 0;
        }
        displayed.tile = h2d.Tile.fromPixels(images[imageIndex]);
    }

    function orderByHue(a: Vector, b: Vector) : Bool {
        return a.toColorHSL().x > b.toColorHSL().x;
    }

    function orderBySaturation(a: Vector, b: Vector) : Bool {
        return a.toColorHSL().y > b.toColorHSL().y;
    }

    function orderByLightness(a: Vector, b: Vector) : Bool {
        return a.toColorHSL().z > b.toColorHSL().z;
    }

    override function onResize() {
        displayed.width = s2d.width;
        displayed.height = s2d.height;
    }

    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}
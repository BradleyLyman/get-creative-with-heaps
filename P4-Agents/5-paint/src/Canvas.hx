import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;
import h3d.mat.Texture;
import hxd.Window;
import hxd.Pixels;

/**
  Objects of this type represent a persistent on-screen image. The contents
  of the canvas are not cleared from frame to frame.
**/
class Canvas {
  @:isVar public var root(default, null):Object;

  private var texture:Texture;
  private var bmp:Bitmap;
  private var window:Window;
  private var pixels:Pixels;
  private final resolution:Int;

  /**
    Create a new fullscreen canvas which renders itself to the parent scene.
  **/
  public function new(parent:Scene, resolution:Int = 1080) {
    this.resolution = resolution;
    window = Window.getInstance();
    window.addResizeEvent(onResize);

    texture = new Texture(1, 1, [Target], RGBA);
    bmp = new Bitmap(Tile.fromTexture(texture), parent);
    bmp.filter = new h2d.filter.Blur(3, 1, 2);
    pixels = texture.capturePixels();

    this.root = new Object();

    onResize();
  }

  /* The last frame's pixel data. */
  public function currentPixels():Pixels {
    return pixels;
  }

  /**
    Reszie the texture and update the bitmap's tile when the window changes
    size.
  **/
  function onResize() {
    final resWidth:Int = Math.round(
      (window.width / window.height) * resolution
    );

    texture.resize(resWidth, resolution);
    bmp.tile = Tile.fromTexture(texture);

    bmp.scaleY = window.height / resolution;
    bmp.scaleX = window.width / resWidth;
    root.scaleY = 1.0 / bmp.scaleY;
    root.scaleX = 1.0 / bmp.scaleX;

    pixels.dispose();
    pixels = texture.capturePixels();
  }

  /**
    Update the canvas's contents.
    If this isn't called then the scene's contents will not be visible on
    screen.
  **/
  public function update() {
    root.drawTo(texture);

    pixels.dispose();
    pixels = texture.capturePixels();
  }
}

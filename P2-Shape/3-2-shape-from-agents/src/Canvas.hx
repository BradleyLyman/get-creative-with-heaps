import h2d.Bitmap;
import h2d.Tile;
import h2d.Scene;
import h2d.Graphics;
import h3d.mat.Texture;
import hxd.Window;
import hxd.Pixels;

/**
  Objects of this type represent a persistent on-screen image. The contents
  of the canvas are not cleared from frame to frame.
**/
class Canvas {
  @:isVar public var graphics(default, null):Graphics;

  private var s2d(default, null):Scene;
  private var texture:Texture;
  private var bmp:Bitmap;
  private var window:Window;

  /**
    Create a new fullscreen canvas which renders itself to the parent scene.
  **/
  public function new(parent:Scene) {
    window = Window.getInstance();
    window.addResizeEvent(onResize);

    texture = new Texture(window.width, window.height, [Target], RGBA);
    bmp = new Bitmap(Tile.fromTexture(texture), parent);

    s2d = new Scene();
    graphics = new Graphics(s2d);
  }

  /**
    Reszie the texture and update the bitmap's tile when the window changes
    size.
  **/
  function onResize() {
    texture.resize(window.width, window.height);
    bmp.tile = Tile.fromTexture(texture);
  }

  /**
    Update the canvas's contents.
    If this isn't called then the scene's contents will not be visible on
    screen.
  **/
  public function update() {
    s2d.drawTo(texture);
    graphics.clear();
  }
}

import h3d.pass.Blur;
import h2d.Bitmap;
import hxd.Window.DisplayMode;
import h2d.Tile;
import h3d.mat.Texture;

/**
    Objects of this type represent a persistent on-screen image. The contents
    of the canvas are not cleared from frame to frame.
**/
class Canvas {

  @:isVar public var s2d (default, null): h2d.Scene;

  private var texture : h3d.mat.Texture;
  private var bmp : h2d.Bitmap;
  private var window : hxd.Window;

  /**
      Create a new fullscreen canvas which renders itself to the parent scene.
  **/
  public function new(parent: h2d.Scene) {
    window = hxd.Window.getInstance();
    window.addResizeEvent(onResize);

    texture = new Texture(window.width, window.height, [Target], RGBA);
    bmp = new Bitmap(Tile.fromTexture(texture), parent);

    s2d = new h2d.Scene();
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
  }
}
package support.h2d.ui;

import h2d.Interactive;
import h2d.Bitmap;
import h2d.Font;
import h2d.Object;
import h2d.Text;
import h2d.Tile;
import hxd.Event;
import hxd.res.DefaultFont;
import support.color.Color;
import support.color.RGBA;

/**
  Objects of this class represent a clickable button which has text and a
  background color.

  Convenient for applications where a dedicated texture isn't needed for a
  button.
**/
class TextButton extends Object {
  /**
    The Button's text should hint at what it does when clicked.
    The button's size is determined automatically when the text is updated.
  **/
  public var text(get, set):String;

  /* The function to invoke when the button is clicked. */
  public var onClick(get, set):(e:Event) -> Void;

  private final padding:Float;
  private final visual:Text;
  private final background:Bitmap;
  private final overlay:Bitmap;
  private final interactive:Interactive;

  @:isVar private var width(get, set):Float;
  @:isVar private var height(get, set):Float;

  /**
    Create a new clickable button.
    @param parent the button's parent in the scene
    @param color the button's background color
    @param font the font, can be omitted to use the default
  **/
  public function new(parent:Object, ?color:Color, ?font:Font) {
    super(parent);
    font = font != null ? font : DefaultFont.get();
    color = color != null ? color : new RGBA();

    this.background = new Bitmap(
      Tile.fromColor(color.toRGBA().toARGBInt(), 1, 1, 1),
      this
    );
    this.overlay = new Bitmap(Tile.fromColor(0xFFFFFF, 1, 1, 0.25), this);
    this.visual = new Text(font, this);
    this.interactive = new Interactive(1, 1, this);

    this.overlay.visible = false;
    this.padding = font.lineHeight * 0.25;
    this.visual.x = padding;
    this.visual.y = padding;

    this.width = 0;
    this.height = 0;

    this.interactive.onOut = (_) -> {
      this.overlay.visible = false;
    };
    this.interactive.onPush = (_) -> {
      this.overlay.visible = false;
    };
    this.interactive.onReleaseOutside = (_) -> {
      this.overlay.visible = false;
    };
    this.interactive.onOver = (_) -> {
      this.overlay.visible = true;
    };
    this.interactive.onRelease = (_) -> {
      this.overlay.visible = true;
    };
  }

  /* When the text is set, recompute the width and height */
  private function set_text(text:String):String {
    visual.text = text;
    this.width = visual.textWidth + padding * 2;
    this.height = visual.textHeight + padding * 2;
    return text;
  }

  private function get_text():String {
    return visual.text;
  }

  private function get_width():Float {
    return this.width;
  }

  private function get_height():Float {
    return this.height;
  }

  /**
    When the width is set the background, overlay, and interactive all need
    to be updated.
  **/
  private function set_width(w:Float):Float {
    background.scaleX = w;
    overlay.scaleX = w;
    interactive.width = w;
    return this.width = w;
  }

  /**
    When the height is set, the background, overlay, and interactive all need
    to be updated.
  **/
  private function set_height(h:Float):Float {
    background.scaleY = h;
    overlay.scaleY = h;
    interactive.height = h;
    return this.height = h;
  }

  private function get_onClick():(e:Event) -> Void {
    return interactive.onClick;
  }

  private function set_onClick(f:(e:Event) -> Void):(e:Event) -> Void {
    return interactive.onClick = f;
  }
}

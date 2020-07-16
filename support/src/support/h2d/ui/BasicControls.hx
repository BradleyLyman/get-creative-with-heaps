package support.h2d.ui;

import hxd.res.DefaultFont;
import h2d.Text;
import support.color.Color;
import h2d.Flow;
import h2d.Tile;
import h2d.Font;
import support.color.HSL;

/**
  Objects of this type represent a fullscreen panel which can host simple
  controls for demo parameters.

  Controls take the form of buttons and sliders which can be added with their
  respective methods.

  This class is 'basic' because it does not support the heaps domkit, css,
  or any scenarios where there are more controls than trivially fit on a
  single screen.
**/
class BasicControls extends Flow {
  private final MARGIN:Float = 0.1;
  private final font:Font;
  private final showHide:TextButton;
  private final sliders:Array<NamedSlider> = [];

  public var backgroundColor(null, set):Color;

  /**
    Create a new control panel.
    @param parent the scene
    @param font
      A font to use for text and buttons, falls back to the default if
      unspecified.
  **/
  public function new(parent:h2d.Scene, ?font:Font) {
    super(parent);

    this.visible = false;
    this.font = font != null ? font : DefaultFont.get();

    this.layout = Vertical;
    this.backgroundColor = new HSL(260, 0.15, 0.25, 0.96);
    this.verticalAlign = Top;
    this.horizontalAlign = Left;
    this.verticalSpacing = Math.round(this.font.lineHeight * 0.5);

    hxd.Window.getInstance().addResizeEvent(onResize);
    onResize();

    this.showHide = new TextButton(parent, new HSL(240, 0.4, 0.25), this.font);
    this.showHide.text = this.visible ? "hide controls" : "show controls";
    this.showHide.onClick = (_) -> {
      this.visible = !this.visible;
      this.showHide.text = this.visible ? "hide controls" : "show controls";
    };
  }

  /* Add spacing to the flow. Units are relative to the font height. */
  public override function addSpacing(em:Float) {
    super.addSpacing(Math.round(em * font.lineHeight));
  }

  /* Add a slider with a label to the control panel flow */
  public function addSlider(
    name:String,
    min:Float = 0,
    max:Float = 1
  ):NamedSlider {
    final slider = new NamedSlider(this, min, max, font);
    slider.label = name;
    sliders.push(slider);
    onResize();
    return slider;
  }

  /* Add some arbitrary text to the control panel flow */
  public function addText(label:String):Text {
    final text = new Text(font, this);
    text.text = label;
    return text;
  }

  /* Add a text button to the control panel flow. */
  public function addButton(label:String, color:Color):TextButton {
    final button = new TextButton(this, color, font);
    button.text = label;
    return button;
  }

  private function onResize() {
    final w = hxd.Window.getInstance();
    final size = Math.round(Math.min(w.height, w.width) * (1.0 - MARGIN));
    this.x = (w.width - size) / 2.0;
    this.y = (w.height - size) / 2.0;
    this.padding = Math.round(font.lineHeight);

    for (slider in sliders) {
      slider.maxWidth = slider.minWidth = Math.round(size * 0.75);
      slider.onResize();
    }

    this.minHeight = this.maxHeight = size;
    this.minWidth = this.maxWidth = size;
    this.needReflow = true;
  }

  private function set_backgroundColor(c:Color):Color {
    final rgba = c.toRGBA();
    backgroundTile = Tile.fromColor(rgba.toARGBInt(), 1, 1, rgba.a);
    return c;
  }
}

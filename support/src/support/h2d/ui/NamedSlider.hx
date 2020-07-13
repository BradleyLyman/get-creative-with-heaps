package support.h2d.ui;

import h2d.Flow;
import h2d.Font;
import h2d.Object;
import h2d.Slider;
import h2d.Text;
import hxd.res.DefaultFont;

/**
    Objects of this type represent a slider with a label and value display.
**/
class NamedSlider extends Flow {
  private final text : Text;
  private final valText : Text;
  private final control : Slider;

  /* The value represented by the slider */
  public var value(get, set) : Float;

  /* The slider's text label */
  @:isVar public var label(get, set) : String;

  /* A function to call when the slider's value changes */
  public var onChange: () -> Void = () -> {};

  /**
      Create a new labeled slider. Falls back to the default font if one is not
      provided.

      @param parent the parent of this named slider
      @param min the minimum slider value
      @param max the maximum slider value
      @param font optionally specify a font, falls back to the heaps default
  **/
  public function new(parent: Object, min: Float, max: Float, ?font: Font) {
    font = font != null ? font : DefaultFont.get();
    super(parent);

    this.layout = Horizontal;
    this.horizontalAlign = Left;
    this.verticalAlign = Middle;

    text = new Text(font, this);
    control = new Slider(0, Math.ceil(font.lineHeight), this);
    valText = new Text(font, this);
    control.minValue = min;
    control.maxValue = max;

    control.onChange = handleValueChange;
    updateValText();
  }

  /* Tell the slider that it's maximum width has been changed. */
  public function onResize() {
    control.width = this.maxWidth * 0.5;

    // this line is a litle weird. The slider will not update the tile's size
    // unless it's *value* is changed after the width has been changed.
    // This little line just forces the internal tile to update without needing
    // the value to change. Without this, the slider will not resize properly
    // when the screen shrinks
    control.tile.setSize(control.width, control.tile.height);

    this.needReflow = true;
  }

  private function handleValueChange() {
    updateValText();
    onChange();
  }

  private function set_label(label: String) : String {
    text.text = label + " ";
    this.needReflow = true;
    return label;
  }

  private function updateValText() {
    final val = '${hxd.Math.fmt(control.value)}';
    valText.text = " = " + val;
    this.needReflow = true;
  }

  private function get_label() { return label; }
  private function get_value() { return control.value; }
  private function set_value(v) {
    control.value = v;
    control.onChange();
    return v;
  }
}

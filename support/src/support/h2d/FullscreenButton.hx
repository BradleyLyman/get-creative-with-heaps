package support.h2d;

import support.linAlg2d.Quad;
import support.color.RGBA;
import h2d.Drawable;
import hxd.Window.DisplayMode;

/**
  Objects of this class represent a button which toggles the fullscreen
  setting for the demo.

  The button image is dynamically generated so there's no need to worry about
  resources when using this button.
**/
class FullscreenButton extends Drawable {
  /* The clickable region of the button. */
  var clickable:h2d.Interactive;

  /* The button's visual component. */
  var fastQuads:FastQuads;

  /* A reference to the window, used for events and getting dimensions */
  var window:hxd.Window;

  var dimensions:{
    size:Float,
    lineSize:Float,
    offset:Float
  };

  /**
    Create a new fullscreen button in the bottom right of the screen.
    Resizing and redrawing are handled automatically.
  **/
  public function new(parent:h2d.Scene) {
    super(parent);
    fastQuads = new FastQuads(this);
    clickable = new h2d.Interactive(1, 1, this);
    clickable.onClick = onClick;

    window = hxd.Window.getInstance();
    window.addResizeEvent(onResize);

    onResize();
    render();
  }

  /**
    Compute the button's dimensions based on the window's position.
  **/
  private function updateDimensions() {
    final size = Math.max(Math.min(window.width, window.height) / 24, 24);
    dimensions = {
      size: size,
      lineSize: Math.max(size / 24, 1.0),
      offset: Math.max(size / 6, 2.0)
    };
  }

  /**
    Resize and reposition the button when the screen's size changes.
  **/
  private function onResize() {
    updateDimensions();
    clickable.width = dimensions.size;
    clickable.height = dimensions.size;

    this.x = window.width - (dimensions.size * 2);
    this.y = window.height - (dimensions.size * 2);
    fastQuads.x = dimensions.size / 2;
    fastQuads.y = dimensions.size / 2;

    render();
  }

  /**
    Toggle between fullscreen and windowed when the fullscreen button
    is clicked.
  **/
  private function onClick(e:hxd.Event) {
    window.displayMode = switch (window.displayMode) {
      case DisplayMode.Windowed: DisplayMode.Fullscreen;
      case DisplayMode.Fullscreen: DisplayMode.Windowed;
      default: DisplayMode.Windowed;
    };
  }

  /**
    Render the button using the computed dimensions.
  **/
  private function render() {
    fastQuads.clear();

    // draw the background rect
    fastQuads.addQuad(
      Quad.aligned(
        -dimensions.size / 2,
        -dimensions.size / 2,
        dimensions.size / 2,
        dimensions.size / 2
      ),
      new RGBA(1, 1, 1, 0.3)
    );

    final offset = dimensions.offset;

    final top = (-dimensions.size / 2) + offset;
    final left = (-dimensions.size / 2) + offset;
    final bottom = (dimensions.size / 2) - offset;
    final right = (dimensions.size / 2) - offset;

    // draw arrows
    final lines = fastQuads.newTurtle();
    lines.lineWidth = dimensions.lineSize;

    // draw radial lines
    lines.moveTo(offset, offset).lineTo(right, bottom);
    lines.moveTo(-offset, offset).lineTo(left, bottom);
    lines.moveTo(offset, -offset).lineTo(right, top);
    lines.moveTo(-offset, -offset).lineTo(left, top);

    // draw arrowheads
    lines.moveTo(left, top).lineTo(-offset, top);
    lines.moveTo(left, top).lineTo(left, -offset);

    lines.moveTo(right, top).lineTo(offset, top);
    lines.moveTo(right, top).lineTo(right, -offset);

    lines.moveTo(left, bottom).lineTo(-offset, bottom);
    lines.moveTo(left, bottom).lineTo(left, offset);

    lines.moveTo(right, bottom).lineTo(offset, bottom);
    lines.moveTo(right, bottom).lineTo(right, offset);
  }
}

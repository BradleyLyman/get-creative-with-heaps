package support.h2d;

import hxd.Window.DisplayMode;

/**
    Objects of this class represent a button which toggles the fullscreen
    setting for the demo.

    The button image is dynamically generated so there's no need to worry about
    resources when using this button.
**/
class FullscreenButton {
  /* The button's root establishes the origin for all coordinates. */
  var root : h2d.Object;

  /* The clickable region of the button. */
  var clickable : h2d.Interactive;

  /* The button's visual component. */
  var graphics : h2d.Graphics;

  /* A reference to the window, used for events and getting dimensions */
  var window : hxd.Window;

  var dimensions : {
    size: Float,
    lineSize: Float,
    offset: Float
  };

  /**
      Create a new fullscreen button in the bottom right of the screen.
      Resizing and redrawing are handled automatically.
  **/
  public function new(parent: h2d.Scene) {
    root = new h2d.Object(parent);
    graphics = new h2d.Graphics(root);
    clickable = new h2d.Interactive(1, 1, root);
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
    final size = Math.max(Math.min(window.width, window.height) / 20, 20);
    dimensions = {
      size: size,
      lineSize: Math.max(size / 24, 1.0),
      offset: Math.max(size / 6, 2)
    };
  }

  /**
      Resize and reposition the button when the screen's size changes.
  **/
  private function onResize() {
    updateDimensions();
    clickable.width = dimensions.size;
    clickable.height = dimensions.size;

    root.x = window.width - (dimensions.size*2);
    root.y = window.height - (dimensions.size*2);
    graphics.x = dimensions.size / 2;
    graphics.y = dimensions.size / 2;

    render();
  }

  /**
      Toggle between fullscreen and windowed when the fullscreen button
      is clicked.
  **/
  private function onClick(e: hxd.Event) {
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
    graphics.clear();

    // draw the background rect
    graphics.beginFill(0xFFFFFF, 0.3);
    graphics.drawRoundedRect(
      -dimensions.size/2, -dimensions.size/2, // position
      dimensions.size, dimensions.size,       // size
      dimensions.offset                       // corner radius
    );
    graphics.endFill();

    final offset = dimensions.offset;

    final top = (-dimensions.size/2) + offset;
    final left = (-dimensions.size/2) + offset;
    final bottom = (dimensions.size/2) - offset;
    final right = (dimensions.size/2) - offset;

    // draw arrows
    graphics.lineStyle(dimensions.lineSize, 0xFFFFFF, 0.95);

    // draw radial lines
    graphics.moveTo( offset,  offset); graphics.lineTo(right, bottom);
    graphics.moveTo(-offset,  offset); graphics.lineTo(left,  bottom);
    graphics.moveTo( offset, -offset); graphics.lineTo(right, top);
    graphics.moveTo(-offset, -offset); graphics.lineTo(left,  top);

    // draw arrowheads
    graphics.moveTo(left, top); graphics.lineTo(-offset, top);
    graphics.moveTo(left, top); graphics.lineTo(left, -offset);

    graphics.moveTo(right, top); graphics.lineTo(offset, top);
    graphics.moveTo(right, top); graphics.lineTo(right, -offset);

    graphics.moveTo(left, bottom); graphics.lineTo(-offset, bottom);
    graphics.moveTo(left, bottom); graphics.lineTo(left, offset);

    graphics.moveTo(right, bottom); graphics.lineTo(offset, bottom);
    graphics.moveTo(right, bottom); graphics.lineTo(right, offset);
  }
}
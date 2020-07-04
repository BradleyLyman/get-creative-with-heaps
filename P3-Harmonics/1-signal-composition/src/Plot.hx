import h2d.Object;
import h2d.Graphics;
import h2d.Text;

/**
    Objects of this class represent an onscreen cartesian plot.
**/
class Plot {
  /**
      The amount of space this plot occupies on screen. Coordinates are relative
      to the parent.
  **/
  private var screenSize: { width: Float, height: Float};

  /**
      The span for the plot's x and y axis.
  **/
  @:isVar public var axis(default, null): {x: Range, y: Range};

  private var root: Object;
  private var grid: Graphics;

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  public var data : Array<Vector>;

  public var hideAxis : Bool = true;

  static private final INSET = 0.98;
  static private final HALF_INSET = 0.99;

  /**
      Create a new Plot object which can be used to present data on screen.
  **/
  public function new(
    width: Float, height: Float,
    xAxis: Range,
    yAxis: Range,
    parent: h2d.Object
  ) {
    this.screenSize = {width: width, height: height};
    this.axis = {x: xAxis, y: yAxis};
    this.root = new Object(parent);
    this.grid = new Graphics(this.root);
    this.data = [];
  }

  public function resize(width: Float, height: Float) {
    this.screenSize = {width: width, height: height};
  }

  public function render() {
    grid.clear();
    renderBackground();
    if (!hideAxis) { renderAxis(); }
    renderData();
  }

  private function renderBackground() {
    grid.beginFill(0xFFFFFF, 0.1);
    grid.drawRect(0, 0, screenSize.width, screenSize.height);
    grid.endFill();
  }

  private function renderAxis() {
    // baseline position
    // maps for the axis coords
    final xMap = axis.x.mapTo([
      screenSize.width * (1.0-INSET), screenSize.width * INSET
    ]);
    final yMap = axis.y.mapTo([
      screenSize.height * INSET, screenSize.height * (1.0-INSET)
    ]);

    grid.lineStyle(2, 0xFFFFFF, 1.0);
    grid.moveTo(
      xMap(axis.x.min - axis.x.size()*(1.0-HALF_INSET)), yMap(axis.y.min)
    );
    grid.lineTo(
      xMap(axis.x.max + axis.x.size()*(1.0-HALF_INSET)), yMap(axis.y.min)
    );

    grid.moveTo(
      xMap(axis.x.min), yMap(axis.y.min - axis.y.size()*(1.0-HALF_INSET))
    );
    grid.lineTo(
      xMap(axis.x.min), yMap(axis.y.max + axis.y.size()*(1.0-HALF_INSET))
    );
  }

  private function renderData() {
    if (data.length == 0) { return; }

    final xMap = axis.x.clampMapTo([
      screenSize.width * (1.0-INSET), screenSize.width * INSET
    ]);
    final yMap = axis.y.clampMapTo([
      screenSize.height * INSET, screenSize.height * (1.0-INSET)
    ]);

    grid.lineStyle(2, 0xFFFFFF, 1.0);
    grid.moveTo(xMap(data[0].x), yMap(data[0].y));
    grid.beginFill(0, 0);
    for (point in data) {
      grid.lineTo(xMap(point.x), yMap(point.y));
    }
    grid.endFill();
  }

  public function get_x() { return root.x; }
  public function set_x(v) { return root.x = v; }
  public function get_y() { return root.y; }
  public function set_y(v) { return root.y = v; }
}
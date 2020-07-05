import support.Turtle;
import hxd.fmt.hmd.Data.Position;
import h2d.Object;
import h2d.Graphics;
import h2d.Text;
import support.h2d.FastLines;
import support.Turtle;

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
  private var fastLines: FastLines;

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  public var data: {
    x: haxe.ds.Vector<Float>,
    y: haxe.ds.Vector<Float>
  };

  static private final INSET = 0.98;
  static private final HALF_INSET = 0.99;

  /**
      Create a new Plot object which can be used to present data on screen.
  **/
  public function new(
    xAxis: Range,
    yAxis: Range,
    parent: h2d.Object
  ) {
    this.screenSize = {width: 100, height: 100};
    this.axis = {x: xAxis, y: yAxis};
    this.root = new Object(parent);
    this.grid = new Graphics(this.root);
    this.fastLines = new FastLines(this.root);
    this.data = {x: new haxe.ds.Vector(0), y: new haxe.ds.Vector(0)};
  }

  public function dispose() {
    this.root.parent.removeChild(this.root);
  }

  public function resize(width: Float, height: Float) {
    this.screenSize = {width: width, height: height};
  }

  public function render() {
    grid.clear();
    fastLines.clear();
    renderBackground();
    renderData();
  }

  private function renderBackground() {
    grid.beginFill(0xFFFFFF, 0.1);
    grid.drawRect(0, 0, screenSize.width, screenSize.height);
    grid.endFill();
  }

  private function renderData() {
    if (data.x.length == 0 || data.x.length != data.y.length) { return; }

    final xMap = axis.x.clampMapTo(Range.of(
      screenSize.width * (1.0-INSET), screenSize.width * INSET
    ));
    final yMap = axis.y.clampMapTo(Range.of(
      screenSize.height * INSET, screenSize.height * (1.0-INSET)
    ));

    final turtle = new Turtle(fastLines);
    turtle.lineWidth = 2;
    turtle.moveTo(xMap(data.x[0]), yMap(data.y[0]));
    for (i in 0...data.x.length) {
      turtle.lineTo(
        xMap(data.x[i]), yMap(data.y[i])
      );
    }
  }

  public function get_x() { return root.x; }
  public function set_x(v) { return root.x = v; }
  public function get_y() { return root.y; }
  public function set_y(v) { return root.y = v; }
}
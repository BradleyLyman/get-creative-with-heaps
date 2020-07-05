import h2d.Object;
import support.h2d.FastLines;
import support.Turtle;

class Main extends hxd.App {

  var root : Object;
  var fastLines : FastLines;
  var space: Space = new Space();
  var xAxis : Range;
  var yAxis : Range;

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
    root = new Object(s2d);
    fastLines = new FastLines(root);
    new support.h2d.FullscreenButton(s2d);

    space.xIn = new Interval(-1, 1);
    space.yIn = new Interval(-1, 1);

    onResize();
  }

  function draw() {
    fastLines.clear();
    final t = new SpaceTurtle(fastLines, space);
    t.lineWidth = 1.0;
    t.moveTo(-1, 0).lineTo(1, 0);
    t.moveTo(0, -1).lineTo(0, 1);
  }

  override function onResize() {
    root.x = s2d.width / 4;
    root.y = s2d.height / 4;
    space.yOut = new Interval(s2d.height / 2, 0);
    space.xOut = new Interval(0, s2d.width / 2);
    draw();
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
  }

  static function main() {
    new Main();
  }
}
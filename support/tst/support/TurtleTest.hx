package support;

import utest.Assert;
import support.Turtle;
import support.linAlg2d.Line;
import support.linAlg2d.Vec;

class TurtleTest extends utest.Test {

  var view : ArrayView;
  var turtle: Turtle;

  function setup() {
    view = new ArrayView();
    turtle = new Turtle(view);
  }

  function testMoveWithoutLine() {
    turtle
      .moveTo(0, 0)
      .moveTo(1, 1)
      .moveTo(2, 2)
      .moveTo(123, -234);
    Assert.equals(view.lines.length, 0);
    Assert.floatEquals(turtle.position.x, 123.0);
    Assert.floatEquals(turtle.position.y, -234);
  }

  function testLineTo() {
    turtle
      .moveTo(0, 0)
      .lineTo(10, -10);
    Assert.equals(view.lines.length, 1);

    Assert.equals(view.lines[0].width, turtle.lineWidth);
    Assert.equals(view.lines[0].line.start.x, 0);
    Assert.equals(view.lines[0].line.start.y, 0);
    Assert.equals(view.lines[0].line.end.x, 10);
    Assert.equals(view.lines[0].line.end.y, -10);

    Assert.floatEquals(turtle.position.x, 10);
    Assert.floatEquals(turtle.position.y, -10);
  }
}

class ArrayView implements Turtle.View {
  public final lines : Array<{line: Line, width: Float}> = [];

  public function new() {}

  public function addLine(line: Line, width: Float) {
    lines.push({
      line: line,
      width: width
    });
  }
}
package support.turtle;

import utest.Assert;
import format.mp3.Constants.CEmphasis;
import support.linAlg2d.Vec;
import support.linAlg2d.Line;

class DecoratedTurtleTest extends utest.Test {

  var wrapped: ObservableTurtle;
  var turtle: DecoratedTurtle;

  function before() {
    wrapped = new ObservableTurtle();
    turtle = new DecoratedTurtle(wrapped);
  }

  /* the decorated turtle's position should reflect the wrapped turtle */
  function testPositionChange() {
    // when the wrapped turtle's position is changed
    wrapped.position.add(new Vec(1, 1));

    // then the decorated turtle's position should match
    Assert.floatEquals(wrapped.position.x, turtle.position.x);
    Assert.floatEquals(wrapped.position.y, turtle.position.y);
  }

  /* moving the decorated turtle should modify the wrapped turtle's position */
  function testMove() {
    // when the turtle moves
    turtle.position = new Vec(2, 2);

    // then the decated turtle's position should match the wrapped position
    Assert.floatEquals(turtle.position.x, wrapped.position.x);
    Assert.floatEquals(turtle.position.y, wrapped.position.y);
  }

  function testMoveWithoutLine() {
    turtle
      .moveTo(0, 0)
      .moveTo(1, 1)
      .moveTo(2, 2)
      .moveTo(123, -234);
    Assert.equals(wrapped.lines.length, 0);
    Assert.floatEquals(turtle.position.x, 123.0);
    Assert.floatEquals(turtle.position.y, -234);
  }

  function testLineTo() {
    turtle
      .moveTo(0, 0)
      .lineTo(10, -10);
    Assert.equals(wrapped.lines.length, 1);

    Assert.equals(wrapped.lines[0].lineWidth, turtle.lineWidth);
    Assert.equals(wrapped.lines[0].line.start.x, 0);
    Assert.equals(wrapped.lines[0].line.start.y, 0);
    Assert.equals(wrapped.lines[0].line.end.x, 10);
    Assert.equals(wrapped.lines[0].line.end.y, -10);

    Assert.floatEquals(turtle.position.x, 10);
    Assert.floatEquals(turtle.position.y, -10);
  }
}

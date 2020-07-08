package support.turtle;

import utest.Assert;
import support.linAlg2d.Vec;

using support.linAlg2d.AssertVec;

class DecoratedTurtleTest extends utest.Test {
  var wrapped: ObservableTurtle;
  var turtle: DecoratedTurtle;

  public function setup() {
    wrapped = new ObservableTurtle();
    turtle = new DecoratedTurtle(wrapped);
  }

  function testWrappedPositionChange() {
    // when the wrapped turtle's position is changed
    wrapped.position.add(new Vec(1, 1));

    Assert.vecEquals(
      wrapped.position, turtle.position,
      "The turtle's position should match the wrapped turtle"
     );
  }

  function testPositionChange()() {
    // when the turtle moves
    turtle.position = new Vec(2, 2);

    // then the decated turtle's position should match the wrapped position
    Assert.vecEquals(
      turtle.position, wrapped.position,
      "Then the wrapped turtle's position should match"
    );
  }

  function testLineWidth() {
    // when the turtle's line width changes
    turtle.lineWidth = 2;

    // then the decorated turtle's line width should still match
    Assert.floatEquals(turtle.lineWidth, wrapped.lineWidth);
  }

  function testMoveWithoutLine() {
    turtle
      .moveTo(0, 0)
      .moveTo(1, 1)
      .moveTo(2, 2)
      .moveTo(123, -234);
    Assert.equals(0, wrapped.lines.length, "no lines should have been emitted");
    Assert.vecEquals(
      new Vec(123, -234), turtle.position,
      "The turtle should be moved"
    );
  }

  function testLineTo() {
    turtle
      .moveTo(0, 0)
      .lineTo(10, -10);
    Assert.equals(1, wrapped.lines.length, "one line should be emitted");
    Assert.vecEquals(
      new Vec(0, 0),
      wrapped.lines[0].line.start,
      "The line should start at the turtle's previous position"
    );
    Assert.vecEquals(
      new Vec(10, -10),
      wrapped.lines[0].line.end,
      "The line should end at the turtles new position."
    );
    Assert.vecEquals(
      new Vec(10, -10), turtle.position,
      "The turtle should be moved to the line's endpoint."
    );
  }
}

package support.turtle;

import utest.Assert;
import support.linAlg2d.Vec;

using support.linAlg2d.AssertVec;

class DecoratedTurtleTest extends utest.Test {
  var wrapped:ObservableTurtle;
  var turtle:DecoratedTurtle;

  public function setup() {
    wrapped = new ObservableTurtle();
    turtle = new DecoratedTurtle(wrapped);
  }

  function testWrappedPositionChange() {
    // when the wrapped turtle's position is changed
    wrapped.position = new Vec(1, 1);
    Assert.vecEquals(
      wrapped.position,
      turtle.position,
      "Then the outer turtle's position should match the wrapped turtle"
    );

    // when the outer turtle's position is changed
    turtle.position = new Vec(2, 2);
    Assert.vecEquals(
      turtle.position,
      wrapped.position,
      "Then the wrapped turtle's position should the outer turtle"
    );
  }

  function testLineWidth() {
    // when the outer turtle's line width changes
    turtle.lineWidth = 2;
    Assert.floatEquals(turtle.lineWidth, wrapped.lineWidth);

    // when the wrapped turtle's line width changes
    wrapped.lineWidth = 5;
    Assert.floatEquals(wrapped.lineWidth, turtle.lineWidth);
  }

  function testMove() {
    // When the outer turtle moves
    turtle.moveTo(123, -234);
    Assert.equals(0, wrapped.lines.length, "no lines should be emitted");
    Assert.vecEquals(
      new Vec(123, -234),
      turtle.position,
      "The outer turtle's position should be updated"
    );

    // when the wrapped turtle moves
    wrapped.moveTo(-834, 332);
    Assert.equals(0, wrapped.lines.length, "no lines should be emitted");
    Assert.vecEquals(
      new Vec(-834, 332),
      turtle.position,
      "The outer turtle's position should still be updated."
    );
  }

  function testLineTo() {
    turtle.moveTo(0, 0).lineTo(10, -10);
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
      new Vec(10, -10),
      turtle.position,
      "The turtle should be moved to the line's endpoint."
    );
  }
}

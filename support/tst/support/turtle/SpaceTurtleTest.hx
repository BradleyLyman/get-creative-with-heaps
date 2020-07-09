package support.turtle;

import h3d.shader.pbr.CubeLod;
using support.linAlg2d.AssertVec;

import utest.Assert;

import support.linAlg2d.Vec;
import support.linAlg2d.Interval;

class SpaceTurtleTest extends utest.Test {

  var wrapped : ObservableTurtle;
  var turtle : SpaceTurtle;

  public function setup() {
    wrapped = new ObservableTurtle();
    turtle = new SpaceTurtle(wrapped);
    turtle.space.xIn = new Interval(-1, 1);
    turtle.space.yIn = new Interval(-1, 1);
    turtle.space.xOut = new Interval(100, 200);
    turtle.space.yOut = new Interval(200, 100);
  }

  function testMoveTurtle() {
    turtle.moveTo(1, 1);
    Assert.vecEquals(
      new Vec(1, 1), turtle.position,
      "The turtle's position should be in the input space"
    );
    Assert.vecEquals(
      new Vec(200, 100), wrapped.position,
      "The wrapped turtle's position should be in the output space"
    );
  }

  function testSetPosition() {
    turtle.position = new Vec(-1, 1);
    Assert.vecEquals(
      new Vec(-1, 1), turtle.position,
      "The turtle's position should be in the input space"
    );
    Assert.vecEquals(
      new Vec(100, 100), wrapped.position,
      "The turtle's position should be in the output space"
    );
  }

  function testLineTo() {
    turtle.moveTo(0, 1).lineTo(1, -1);
    Assert.vecEquals(
      new Vec(1, -1), turtle.position,
      "The turtle's position should be updated in the input space"
    );
    Assert.vecEquals(
      new Vec(200, 200), wrapped.position,
      "The wrapped turtle's position should be updated in the output space"
    );

    // one line should be emitted
    Assert.equals(1, wrapped.lines.length);
    Assert.vecEquals(
      new Vec(150, 100), wrapped.lines[0].line.start,
      "The line's start point should be in the output space"
    );
    Assert.vecEquals(
      new Vec(200, 200), wrapped.lines[0].line.end,
      "The line's end point should be in the output space"
    );
  }
}
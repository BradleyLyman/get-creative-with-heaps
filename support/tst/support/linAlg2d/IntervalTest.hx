package support.linAlg2d;

import utest.Assert;

class IntervalTest extends utest.Test {
  function testClamp() {
    // given an interval
    final i = new Interval(-10, 25);

    // values beyond the range should be clamped to their endpoints
    Assert.floatEquals(-10, i.clamp(-11));
    Assert.floatEquals(25, i.clamp(34));

    // values within the range should not be modified
    // get a value on the interval
    Assert.floatEquals(7, i.clamp(7));
  }

  function testClampInverted() {
    // given an interval where the end is less than the start
    final i = new Interval(25, -10);

    // values beyond the range should be clamped to their endpoints
    Assert.floatEquals(-10, i.clamp(-11));
    Assert.floatEquals(25, i.clamp(34));

    // values within the range should not be modified
    // get a value on the interval
    Assert.floatEquals(7, i.clamp(7));
  }

  function testNormalize() {
    // given some new interval
    final i = randomInterval();

    // a value equal to the start should normalize to 0
    Assert.floatEquals(0.0, i.normalize(i.start));

    // a value equal to the end should normalize to 1.0
    Assert.floatEquals(1.0, i.normalize(i.end));

    // the midpoint sholud normalize to 0.5
    Assert.floatEquals(0.5, i.normalize((i.start + i.end) / 2));
  }

  function testLerp() {
    // given some new interval
    final i = randomInterval();

    // Lerping 0 should equal the start value
    Assert.floatEquals(i.start, i.lerp(0.0));

    // Lerping 1 should equal the end value
    Assert.floatEquals(i.end, i.lerp(1.0));

    // Lerping 0.5 should be the midpoint
    Assert.floatEquals((i.start + i.end) / 2.0, i.lerp(0.5));

    // Lerping -1 should move the right distance beyond the start
    Assert.floatEquals(i.start - i.size(), i.lerp(-1));
  }

  function testSize() {
    // given some new interval
    final i = randomInterval();
    Assert.floatEquals(i.end - i.start, i.size());

    // and when inverted
    final inverted = new Interval(i.end, i.start);

    // size should be signed based on the direction of the interval, so
    // switch start and end points will cause the sign to flip
    Assert.floatEquals(i.size() * -1, inverted.size());
  }

  function testSubdivide() {
    final i = randomInterval();
    final divisions:haxe.ds.Vector<Float> = i.subdivide(4);

    // 4 subintervals should have 5 endpoints
    Assert.equals(5, divisions.length);

    // The divisions should start and end with the interval's endpoints
    Assert.floatEquals(i.start, divisions[0]);
    Assert.floatEquals(i.end, divisions[divisions.length - 1]);
  }

  /* generate a random interval */
  private function randomInterval() {
    final a = (Math.random() - Math.random()) * 100;
    final b = (Math.random() - Math.random()) * 100;
    return new Interval(a, b);
  }
}

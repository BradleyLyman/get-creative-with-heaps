package support.linAlg2d;

import utest.Assert;

class SpaceTest extends utest.Test {
  function testMapX() {
    final s = new Space();
    s.xOut = new Interval(100, 300); // imagine a region of pixels on screen
    s.xIn = new Interval(-1, 1); // imagine a normal plot of some kind

    // The mindpoint of the input should map to the midpoint of the output
    Assert.floatEquals(200, s.mapX(0.0));

    // The endpoints should match
    Assert.floatEquals(100, s.mapX(-1));
    Assert.floatEquals(300, s.mapX(1));
  }

  function testMapY() {
    final s = new Space();
    s.yOut = new Interval(500, 200); // imagine a region of pixels on screen
    s.yIn = new Interval(-1, 1); // imagine a normal plot of some kind

    // The mindpoint of the input should map to the midpoint of the output
    Assert.floatEquals(350, s.mapY(0.0));

    // Then endpoints should match
    Assert.floatEquals(500, s.mapY(-1));
    Assert.floatEquals(200, s.mapY(1));
  }
}

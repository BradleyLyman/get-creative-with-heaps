package support.linAlg2d;

import h3d.Vector;
import utest.Assert;
using support.linAlg2d.AssertVec;

class VecTest extends utest.Test {

  public function testAddVectors() {
    final v = new Vec(1, 2).add(new Vec(3, 4));
    Assert.vecEquals(
      v, new Vec(4, 6), "the original vector should hold the sum"
    );
  }

  public function testSubVectors() {
    final v = new Vec(1, 2).sub(new Vec(3, 4));
    Assert.vecEquals(
      v, new Vec(-2, -2), "the original vector should hold the difference"
    );
  }
}
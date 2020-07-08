package support.linAlg2d;

import h3d.shader.ParticleShader;
import h3d.shader.Displacement;
import h3d.Vector;
import utest.Assert;
using support.linAlg2d.AssertVec;

class VecTest extends utest.Test {
  public function testAdd() {
    final v = new Vec(1, 2).add(new Vec(3, 4));
    Assert.vecEquals(
      new Vec(4, 6), v, "the original vector should hold the sum"
    );
  }

  public function testSub() {
    final v = new Vec(1, 2).sub(new Vec(3, 4));
    Assert.vecEquals(
      new Vec(-2, -2), v, "the original vector should hold the difference"
    );
  }

  public function testScale() {
    final v = new Vec(2, 2).scale(0.5);
    Assert.vecEquals(
      new Vec(1, 1), v,
      "The vector should be scaled in place"
    );
  }

  public function testNorm() {
    final v = new Vec(5, 0).norm();
    Assert.floatEquals(1.0, v.len());
    Assert.vecEquals(
        new Vec(1, 0), v,
        "The vector should be rescaled in place."
    );
  }

  public function testLen() {
    final v = new Vec(-1, -1);
    Assert.floatEquals(Math.sqrt(2), v.len());
  }

  public function testRot90() {
    final v = new Vec(-1, 1).rot90();
    final rotated = new Vec(-1, -1);
    Assert.vecEquals(
      rotated, v,
      "The vector should be rotated in place"
    );
  }

  public function testClone() {
    final v = new Vec(1, 1);
    final clonned = v.clone();
    v.add(new Vec(3, 5));
    Assert.vecEquals(
      new Vec(4, 6), v,
      "The original vector should be modified in place"
    );
    Assert.vecEquals(
      new Vec(1, 1), clonned,
      "The clonned vector should not be modified"
    );
  }
}
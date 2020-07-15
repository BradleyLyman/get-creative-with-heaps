package support.linAlg2d;

import format.abc.Data.ABCData;
import utest.Assert;
using support.linAlg2d.AssertVec;

class VecTest extends utest.Test {
  public function testAdd() {
    var v = new Vec(1, 2);
    v.add([3, 4]);
    Assert.vecEquals([4, 6], v, "the original vector should hold the sum");
  }

  public function testCloneAdd() {
    final b: Vec = [2, 3];
    final c: Vec = b + [3, 4];
    Assert.vecEquals([5, 7], c, "the sum should be correct");
    Assert.vecEquals([2, 3], b, "the original should not be mutated");
  }

  public function testSub() {
    var v: Vec = [1, 2];
    v.sub([3, 4]);
    Assert.vecEquals([-2, -2], v, "the original should hold the difference");
  }

  public function testCloneSub() {
    final a: Vec = [1, 2];
    final b: Vec = a - [3, 8];
    Assert.vecEquals([1, 2], a, "the original should not be modified");
    Assert.vecEquals([-2, -6], b, "the difference should be correct");
  }

  public function testScale() {
    var v: Vec = [2, 2];
    v.scale(0.5);
    Assert.vecEquals([1, 1], v, "The vector should be scaled in place");
  }

  public function testCloneScale() {
    final a: Vec = [2, 2];
    final b: Vec = a * 0.5;
    final c: Vec = 0.5 * a;
    Assert.vecEquals([2, 2], a, "The original shouldn't be modified");
    Assert.vecEquals([1, 1], b, "The scale should be computed correctly");
    Assert.vecEquals([1, 1], c, "Scaling should commute");
  }

  public function testNorm() {
    var v: Vec = [5, 0];
    v.norm();
    Assert.floatEquals(1.0, v.len());
    Assert.vecEquals([1, 0], v, "The vector should be rescaled in place.");
  }

  public function testLen() {
    final v = new Vec(-1, -1);
    Assert.floatEquals(Math.sqrt(2), v.len());
  }

  public function testRot90() {
    final v = new Vec(-1, 1).rot90();
    Assert.vecEquals([-1, -1], v, "The vector should be rotated in place");
  }

  public function testClone() {
    final v = new Vec(1, 1);
    final clonned = v.clone();
    v.add(new Vec(3, 5));
    Assert.vecEquals([4, 6], v, "The original should be modified");
    Assert.vecEquals([1, 1], clonned, "The clone should not be modifieb");
  }
}
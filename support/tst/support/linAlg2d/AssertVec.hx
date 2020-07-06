package support.linAlg2d;

import haxe.PosInfos;
import utest.Assert;

/**
    This class provides static extensions for the utest.Assert to enable
    assertions for vector types.
**/
class AssertVec {
  public static function vecEquals(
    assert: Assert,
    expected: Vec,
    actual: Vec,
    ?approx: Float,
    ?msg: String,
    ?pos: haxe.PosInfos
  ) : Void {
    Assert.floatEquals(expected.x, actual.x, approx, "vec.x " + msg, pos);
    Assert.floatEquals(expected.y, actual.y, approx, "vec.y " + msg, pos);
  }
}
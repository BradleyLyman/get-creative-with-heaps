package support.linAlg2d;

import haxe.PosInfos;
import utest.Assert;

/**
    This class provides static extensions for the utest.Assert to enable
    assertions for vector types.
**/
class AssertVec {

  /**
      Assert that two vectors are equal.
      @param assert The utest Assert class which is being extended.
      @param expected The expected Vec() value.
      @param actual The actual Vec() value to be matched against expected.
      @param approx
        The (optional) floating point approximation error. Defaults to 1e-5.
      @param msg The assertion message
      @param pos
        Autopopulated by the compiler and used by Assert to render a pretty
        error report.
  **/
  public static function vecEquals(
    assert: Class<Assert>,
    expected: Vec,
    actual: Vec,
    ?approx: Float = 1e-5,
    ?msg: String,
    ?pos: haxe.PosInfos
  ) : Void {
    var matchMsg = "Expected " + expected + " but got " + actual + ". ";
    if (msg != null) { matchMsg = msg + " - " + matchMsg; }
    Assert.floatEquals(
      expected.x,
      actual.x,
      approx,
      matchMsg + "The X coord doesn't match.",
      pos
    );
    Assert.floatEquals(
      expected.y,
      actual.y,
      approx,
      matchMsg + "The Y coord doesn't match.",
      pos
    );
  }
}
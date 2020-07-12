package support.color;

import utest.Assert;

class AssertRGBA {

  /**
      Assert that two RGBA colors are the same.
      @param assert
        the utest Assert class which will have this method as a static extension
      @param expected The expected color
      @param actual The actual color
      @param approx The floating point approximation tolerance
      @param msg The error message
      @param pos Autopopulated by the compiler to make readable output
  **/
  public static function rgbaEquals(
    assert: Class<Assert>,
    expected: RGBA,
    actual: RGBA,
    ?approx: Float = 1e-5,
    ?msg: String,
    ?pos: haxe.PosInfos
  ) : Void {
    var matchMsg = "Expected " + expected + " but got " + actual + ". ";
    if (msg != null) { matchMsg = msg + " - " + matchMsg; }
    Assert.floatEquals(
      expected.r,
      actual.r,
      approx,
      matchMsg + "The R component doesn't match.",
      pos
    );
    Assert.floatEquals(
      expected.g,
      actual.g,
      approx,
      matchMsg + "The G component doesn't match.",
      pos
    );
    Assert.floatEquals(
      expected.b,
      actual.b,
      approx,
      matchMsg + "The B component doesn't match.",
      pos
    );
    Assert.floatEquals(
      expected.a,
      actual.a,
      approx,
      matchMsg + "The A component doesn't match.",
      pos
    );
  }
}
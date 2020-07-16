package support.color;

import utest.Assert;

using support.color.AssertRGBA;

class HSLTest extends utest.Test {
  function testFullySaturatedToRGBA() {
    Assert.rgbaEquals(new RGBA(1, 0, 0, 1), new HSL(0, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 1, 0, 1), new HSL(60, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 0, 1), new HSL(120, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 1, 1), new HSL(180, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0, 1, 1), new HSL(240, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 0, 1, 1), new HSL(300, 1, 0.5, 1).toRGBA());
  }

  function testOversizedHue() {
    Assert.rgbaEquals(new RGBA(1, 0, 0, 1), new HSL(360, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 1, 0, 1), new HSL(420, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 0, 1), new HSL(480, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 1, 1), new HSL(540, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0, 1, 1), new HSL(600, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 0, 1, 1), new HSL(660, 1, 0.5, 1).toRGBA());
  }

  function testNegativeHue() {
    Assert.rgbaEquals(new RGBA(1, 0, 0, 1), new HSL(0, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 1, 0, 1), new HSL(-300, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 0, 1), new HSL(-240, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 1, 1, 1), new HSL(-180, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0, 1, 1), new HSL(-120, 1, 0.5, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 0, 1, 1), new HSL(-60, 1, 0.5, 1).toRGBA());
  }

  function testBlackWhiteToRGBA() {
    Assert.rgbaEquals(new RGBA(0, 0, 0, 1), new HSL(0, 0, 0, 1).toRGBA());
    Assert.rgbaEquals(new RGBA(1, 1, 1, 1), new HSL(0, 0, 1, 1).toRGBA());
  }

  function testDarkenedToRGBA() {
    Assert.rgbaEquals(new RGBA(0.5, 0, 0), new HSL(0, 1, 0.25).toRGBA());
    Assert.rgbaEquals(new RGBA(0.5, 0.5, 0), new HSL(60, 1, 0.25).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0.5, 0), new HSL(120, 1, 0.25).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0.5, 0.5), new HSL(180, 1, 0.25).toRGBA());
    Assert.rgbaEquals(new RGBA(0, 0, 0.5), new HSL(240, 1, 0.25).toRGBA());
    Assert.rgbaEquals(new RGBA(0.5, 0, 0.5), new HSL(300, 1, 0.25).toRGBA());
  }
}

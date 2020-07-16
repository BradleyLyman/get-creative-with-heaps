package support.color;

import utest.Assert;

class RGBATest extends utest.Test {
  function testToInt() {
    Assert.equals(0xFFFFFFFF, new RGBA(1.0, 1.0, 1.0, 1.0).toARGBInt());

    Assert.equals(0x00FFFFFF, new RGBA(1.0, 1.0, 1.0, 0.0).toARGBInt());
    Assert.equals(0xFF00FFFF, new RGBA(0.0, 1.0, 1.0, 1.0).toARGBInt());
    Assert.equals(0xFFFF00FF, new RGBA(1.0, 0.0, 1.0, 1.0).toARGBInt());
    Assert.equals(0xFFFFFF00, new RGBA(1.0, 1.0, 0.0, 1.0).toARGBInt());

    Assert.equals(0x7FFFFFFF, new RGBA(1.0, 1.0, 1.0, 0.5).toARGBInt());
    Assert.equals(0xFF7FFFFF, new RGBA(0.5, 1.0, 1.0, 1.0).toARGBInt());
    Assert.equals(0xFFFF7FFF, new RGBA(1.0, 0.5, 1.0, 1.0).toARGBInt());
    Assert.equals(0xFFFFFF7F, new RGBA(1.0, 1.0, 0.5, 1.0).toARGBInt());
  }
}

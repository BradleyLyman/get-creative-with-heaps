package support.linAlg2d;

import h3d.shader.pbr.VolumeDecal.DecalOverlay;
import h3d.shader.pbr.VolumeDecal.DecalPBR;

/**
  Objects of this type represent a quadrilateral.
**/
class Quad {
  public var topLeft:Vec;
  public var topRight:Vec;
  public var bottomLeft:Vec;
  public var bottomRight:Vec;

  /* Create a new axis-aligned quad using the provided bounds. */
  static public function aligned(
    top:Float,
    left:Float,
    bottom:Float,
    right:Float
  ) {
    return new Quad(
      new Vec(left, top),
      new Vec(right, top),
      new Vec(left, bottom),
      new Vec(right, bottom)
    );
  }

  /* Create a new quad given the provided coordinates */
  public inline function new(
    topLeft:Vec,
    topRight:Vec,
    bottomLeft:Vec,
    bottomRight:Vec
  ) {
    this.topLeft = topLeft;
    this.topRight = topRight;
    this.bottomLeft = bottomLeft;
    this.bottomRight = bottomRight;
  }
}

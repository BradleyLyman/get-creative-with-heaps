package math2d;

/**
  Objects of this type represent a quadrilateral.
**/
class Quad {
  public var topLeft:Vec;
  public var topRight:Vec;
  public var bottomLeft:Vec;
  public var bottomRight:Vec;

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

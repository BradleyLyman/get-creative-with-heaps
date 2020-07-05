/**
    Objects of this type represent a quadrilateral.
**/
class Quad {
  public var topLeft: Vec2;
  public var topRight: Vec2;
  public var bottomLeft: Vec2;
  public var bottomRight: Vec2;

  /* Create a new quad given the provided coordinates */
  public inline function new(
    topLeft: Vec2, topRight: Vec2, bottomLeft: Vec2, bottomRight: Vec2
  ) {
    this.topLeft = topLeft;
    this.topRight = topRight;
    this.bottomLeft = bottomLeft;
    this.bottomRight = bottomRight;
  }
}

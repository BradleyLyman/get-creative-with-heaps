/**
    Objects of this type represent a 2-dimensional vector.
    Operations favor mutating the vector without a new allocation.
**/
class Vec2 {
  public var x: Float;
  public var y: Float;

  /* Create a new vector */
  public inline function new(x: Float, y: Float) {
    this.x = x;
    this.y = y;
  }

  /* Rotate the vector 90 degrees */
  public inline function rot90(): Vec2 {
    final tempX = this.x;
    this.x = -this.y;
    this.y = tempX;
    return this;
  }

  /* Subtract another vector from this one */
  public inline function sub(v: Vec2): Vec2 {
    this.x -= v.x;
    this.y -= v.y;
    return this;
  }

  /* Add this vector to another */
  public inline function add(v: Vec2): Vec2 {
    this.x += v.x;
    this.y += v.y;
    return this;
  }

  /* Comput this vector's length */
  public inline function len(): Float {
    return Math.sqrt(x*x + y*y);
  }

  /* Normalize this vector so it has length=1 */
  public inline function norm(): Vec2 {
    final len = len();
    return scale(1.0/len);
  }

  /* Scale this vector by a scalar amount */
  public inline function scale(s: Float): Vec2 {
    this.x *= s;
    this.y *= s;
    return this;
  }

  /* Clone this vector into a new object */
  public inline function clone() {
    return new Vec2(x, y);
  }
}
package support.linAlg2d;

/**
    Objects of this type represent a 2-dimensional vector.
    Operations favor mutating the vector without a new allocation.
**/
abstract Vec(haxe.ds.Vector<Float>)
  from haxe.ds.Vector<Float>
  to haxe.ds.Vector<Float>
{
  public var x(get, set): Float;
  public var y(get, set): Float;

  @:from
  static public inline function fromArray(a: Array<Float>) {
    return new Vec(a[0], a[1]);
  }

  @:from
  static public inline function fromIntArray(a: Array<Int>) {
    return new Vec(a[0], a[1]);
  }

  /* Create a new vector using the polar coordinates */
  static public inline function ofPolar(angle: Float, radius: Float) {
    return new Vec(Math.cos(angle)*radius, Math.sin(angle)*radius);
  }

  /* Create a new vector. Just a convenience method. */
  static public inline function of(x: Float, y: Float) {
    return new Vec(x, y);
  }

  /* Create a new vector */
  public inline function new(x: Float, y: Float) {
    this = new haxe.ds.Vector(2);
    this[0] = x;
    this[1] = y;
  }

  /* Rotate the vector 90 degrees */
  public inline function rot90(): Vec {
    final tempX = x;
    x = -y;
    y = tempX;
    return this;
  }

  /* Compute this vector's length */
  public inline function len(): Float {
    return Math.sqrt(sqrLen());
  }

  /* Compute the square of this vector's length */
  public inline function sqrLen(): Float {
    return x*x + y*y;
  }

  /* Normalize this vector so it has length=1 */
  public inline function norm(): Vec {
    final len = len();
    if (len != 0) { return scale(1/len); }
    else { return this; }
  }

  /* Clone this vector into a new object */
  public inline function clone() {
    return new Vec(x, y);
  }

  /**
      Limit the vector's length to some maximum scale.
      @param s - the maximum length
      @return this vector, rescaled if it is longer than s
  **/
  public inline function limit(s: Float): Vec {
    if (sqrLen() > s*s) {
      norm();
      scale(s);
    }
    return this;
  }

  /**
      Return a new vector which is the sum of this and another. The original
      is not modified.
  **/
  @:op(A + B)
  public inline function cloneAdd(rhs: Vec) : Vec {
    return clone().add(rhs);
  }

  @:op(A - B)
  public inline function cloneSub(rhs: Vec) : Vec {
    return clone().sub(rhs);
  }

  @:op(A * B)
  @:commutative
  public inline function cloneScale(s: Float) : Vec {
    return clone().scale(s);
  }

  /* Subtract another vector from this one */
  public inline function sub(v: Vec): Vec {
    x -= v.x;
    y -= v.y;
    return this;
  }

  /* Add this vector to another */
  public inline function add(v: Vec): Vec {
    x += v.x;
    y += v.y;
    return this;
  }

  /* Scale this vector by a scalar amount */
  public inline function scale(s: Float): Vec {
    x *= s;
    y *= s;
    return this;
  }

  /**
      Create a human-readable version of the vector.
      Example:
        trace(new Vec(45, 10));
  **/
  public inline function toString(): String {
    return "Vec(" + x + ", " + y + ")";
  }

  private inline function get_x() { return this[0]; }
  private inline function set_x(x) { return this[0] = x; }
  private inline function get_y() { return this[1]; }
  private inline function set_y(y) { return this[1] = y; }
}
import support.linAlg2d.Vec;

/**
    Objects of this type represent a 2x2 Matrix which can be used to
    rotate and scale data in 2 dimensions.

    Matrix shape:-
    a b
    c d
**/
class Mat {
  public var a: Float;
  public var b: Float;
  public var c: Float;
  public var d: Float;

  static public final UNIT = new Mat(1, 0, 0, 1);

  /* Create a new instance of the matrix */
  public inline function new(a: Float, b: Float, c: Float, d: Float) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }

  /* Multiply this matrix by another. Mutates self. */
  public inline function mul(b: Mat): Mat {
    final ma = this.a;
    final mb = this.b;
    final mc = this.c;
    final md = this.d;

    this.a = ma*b.a + mb*b.c;
    this.b = ma*b.b + mb*b.d;
    this.c = mc*b.a + md*b.c;
    this.d = mc*b.b + md*b.d;

    return this;
  }

  /**
      Transform a column vector by this matrix.
      The Vector is mutated in place and returned.
  **/
  public inline function transformCol(v: Vec): Vec {
    final x = v.x;
    final y = v.y;
    v.x = a*x + b*y;
    v.y = c*x + b*y;
    return v;
  }

  public inline function clone(): Mat {
    return new Mat(a, b, c, d);
  }
}

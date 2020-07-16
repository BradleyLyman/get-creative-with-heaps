abstract Vector(Array<Float>) from Array<Float> to Array<Float> {
  public var x(get, set):Float;
  public var y(get, set):Float;
  public var z(get, set):Float;

  public inline function new(coords:Array<Float>) {
    this = coords;
  }

  public inline function dimension():Int {
    return this.length;
  }

  public inline function length():Float {
    var sum = 0.0;
    for (val in this) {
      sum += (val * val);
    }
    return Math.sqrt(sum);
  }

  @:op(A + B)
  public static function add(lhs:Vector, rhs:Vector) {
    return new Vector([for (i in 0...lhs.dimension()) lhs[i] + rhs[i]]);
  }

  @:op(A - B)
  public static function sub(lhs:Vector, rhs:Vector) {
    return new Vector([for (i in 0...lhs.dimension()) lhs[i] - rhs[i]]);
  }

  @:op(A * B)
  @:commutative
  public static function scale(lhs:Vector, scale:Float):Vector {
    return new Vector([for (i in 0...lhs.dimension()) lhs[i] * scale]);
  }

  public function normalized():Vector {
    return scale(this, 1.0 / length());
  }

  // GETTERS AND SETTERS

  public inline function get_x():Float {
    return this[0];
  }

  public inline function set_x(val:Float):Float {
    this[0] = val;
    return val;
  }

  public inline function get_y():Float {
    return this[1];
  }

  public inline function set_y(val:Float):Float {
    this[1] = val;
    return val;
  }

  public inline function get_z():Float {
    return this[2];
  }

  public inline function set_z(val:Float):Float {
    this[2] = val;
    return val;
  }
}

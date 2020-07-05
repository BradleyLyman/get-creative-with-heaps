package support.linAlg2d;

/**
    A space is a mapping from one interval pair to a second interval pair.
**/
class Space {
  public var xIn : Interval = Interval.UNIT;
  public var xOut : Interval = Interval.UNIT;
  public var yIn : Interval = Interval.UNIT;
  public var yOut : Interval = Interval.UNIT;

  public inline function new() {}

  /**
      Map a value on the x-axis from the xIn interval to the xOut interval.
      @param x a value within the xIn interval
      @return Float a value on the xOut interval
  **/
  public inline function mapX(x: Float): Float {
    final norm = xIn.normalize(xIn.clamp(x));
    return xOut.lerp(norm);
  }

  /**
      Map a value on the y-axis from teh yIn interval to the yOut interval.
      @param y a value within the yIn interval
      @return Float a value on the yOut interval
  **/
  public inline function mapY(y: Float): Float {
    final norm = yIn.normalize(yIn.clamp(y));
    return yOut.lerp(norm);
  }

  /**
      Map the vector using mapX and mapY.
      @param v the vector to map, will be mutated in place
      @return Vec a reference to the passed vector
  **/
  public inline function map(v: Vec): Vec {
    v.x = mapX(v.x);
    v.y = mapY(v.y);
    return v;
  }
}

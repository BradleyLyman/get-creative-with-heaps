package support.linAlg2d;

/**
  A space is a mapping from one interval pair to a second interval pair.
**/
class Space {
  public var xIn:Interval = Interval.UNIT;
  public var xOut:Interval = Interval.UNIT;
  public var yIn:Interval = Interval.UNIT;
  public var yOut:Interval = Interval.UNIT;

  public inline function new() {}

  /**
    Map a value on the x-axis from the xIn interval to the xOut interval.
    @param x a value within the xIn interval
    @return Float a value on the xOut interval
  **/
  public inline function mapX(x:Float):Float {
    final norm = xIn.normalize(xIn.clamp(x));
    return xOut.lerp(norm);
  }

  /**
    Map a value on the y-axis from the yIn interval to the yOut interval.
    @param y a value within the yIn interval
    @return Float a value on the yOut interval
  **/
  public inline function mapY(y:Float):Float {
    final norm = yIn.normalize(yIn.clamp(y));
    return yOut.lerp(norm);
  }

  /**
    Map a value on the x-axis from the xOut interval to the xIn interval.
    @param x a value within the xOut interval
    @return Float a value on the xIn interval
  **/
  public inline function invMapX(x:Float):Float {
    final norm = xOut.normalize(xOut.clamp(x));
    return xIn.lerp(norm);
  }

  /**
    Map a value on the y-axis from the yOut interval to the yIn interval.
    @param y a value within the yOut interval
    @return Float a value on the yIn interval
  **/
  public inline function invMapY(y:Float):Float {
    final norm = yOut.normalize(yOut.clamp(y));
    return yIn.lerp(norm);
  }

  /**
    Map the vector using mapX and mapY.
    @param v the vector to map, will be mutated in place
    @return Vec a reference to the passed vector
  **/
  public inline function map(v:Vec):Vec {
    v.x = mapX(v.x);
    v.y = mapY(v.y);
    return v;
  }

  /**
    Map the vector using invMapX and invMapY.
    @param v the vector to map, will be mutated in place
    @return Vec a reference to the passed vector
  **/
  public inline function invMap(v:Vec):Vec {
    v.x = invMapX(v.x);
    v.y = invMapY(v.y);
    return v;
  }
}

package support.linAlg2d;

/**
    An interval represents a segment of the real numberline fom min to max.
**/
class Interval {
  public var min: Float;
  public var max: Float;

  static public final UNIT : Interval = new Interval(0, 1);

  /* Create a new interval from min to max. */
  public inline function new(min: Float, max: Float) {
    this.min = min;
    this.max = max;
  }

  /* Force a value to stay within the interval's range */
  public inline function clamp(x: Float) : Float {
    if (x <= min) { return min; }
    else if (x >= max) { return max; }
    else { return x; }
  }

  /**
      Return a number between 0 and 1 which represents how far through the
      interval.

      Examples:
          final i = new Interval(2, 6);
          i.normalize(2) == 0; // true
          i.normalize(6) == 1; // true
          i.normalize((6+2)/2) == 0.5; // true
  **/
  public inline function normalize(x: Float) : Float {
    return (x - min)/(max - min);
  }

  /**
      The interval's size.
      Size is signed such that (min + size()) = max.
  **/
  public inline function size() : Float {
    return max - min;
  }

  /**
      Return a number on the interval which is linearlly interpolated from
      min to max.

      Examples:
          final i = new Interval(3, 8);
          i.lerp(0) == 3; // true
          i.lerp(1) == 8; // true
          i.lerp(0.5) == (8+3)/2; // true
  **/
  public inline function lerp(x: Float) : Float {
    return min + x*size();
  }

  /**
      Subdivide an interval into a set of subintervals and return their
      endpoints.

      @param count the number of subintervals.
      @return haxe.ds.Vector<Float> - the endpoint values.
  **/
  public inline function subdivide(count: Int) : haxe.ds.Vector<Float> {
    final endpoints = new haxe.ds.Vector<Float>(count+1);
    for (i in 0...endpoints.length) {
      endpoints[i] = lerp(i/count);
    }
    return endpoints;
  }
}
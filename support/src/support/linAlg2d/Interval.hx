package support.linAlg2d;

/**
    An interval represents a segment of the real numberline.
**/
class Interval {
  public var start: Float;
  public var end: Float;

  static public final UNIT : Interval = new Interval(0, 1);

  /* Create a new interval from start to end. */
  public inline function new(start: Float, end: Float) {
    this.start = start;
    this.end = end;
  }

  /* Force a value to stay within the interval's range */
  public inline function clamp(x: Float) : Float {
    final min = Math.min(start, end);
    final max = Math.max(start, end);
    if (x <= min ) { return min; }
    else if (x >= max ) { return max; }
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
    return (x - start)/(end - start);
  }

  /**
      Return a number on the interval which is linearlly interpolated from
      start to end.

      Examples:
          final i = new Interval(3, 8);
          i.lerp(0) == 3; // true
          i.lerp(1) == 8; // true
          i.lerp(0.5) == (8+3)/2; // true
  **/
  public inline function lerp(x: Float) : Float {
    return start + x*size();
  }

  /**
      The interval's size.
      Size is signed such that (start + size()) = end.
  **/
  public inline function size() : Float {
    return end - start;
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

  public function toString() : String {
    return "Interval[" + start + ", " + end + "]";
  }
}
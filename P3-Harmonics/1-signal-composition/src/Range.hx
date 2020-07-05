/**
    A range is a 2-array of shape [min, max].

    No checks are done for the array size, so large arrays will silently work
    (the larger values ignored), and smaller arrays will result in runtime
    errors.
**/
class Range {
  public final min: Float;
  public final max: Float;

  static public final UNIT : Range = Range.of(0, 1);

  static public inline function of(min: Float, max: Float) : Range {
    return new Range(min, max);
  }

  public inline function new(min: Float, max: Float) {
    this.min = min;
    this.max = max;
  }

  public inline function clamp(x: Float) : Float {
    if (x <= min) { return min; }
    else if (x >= max) { return max; }
    else { return x; }
  }

  public inline function normalize(x: Float) : Float {
    return (x - min)/(max - min);
  }

  public inline function size() : Float {
    return max - min;
  }

  public inline function lerp(x: Float) : Float {
    return min + x*size();
  }

  public inline function mapTo(to: Range) : (Float) -> Float {
    return (x) -> { return to.lerp(normalize(x)); };
  }

  public inline function clampMapTo(to: Range) : (Float) -> Float {
    final mapToRange = mapTo(to);
    return (x) -> { return mapToRange(clamp(x)); }
  }

  public inline function subdivide(count: Int) : haxe.ds.Vector<Float> {
    final endpoints = new haxe.ds.Vector<Float>(count+1);
    for (i in 0...endpoints.length) {
      endpoints[i] = lerp(i/count);
    }
    return endpoints;
  }
}
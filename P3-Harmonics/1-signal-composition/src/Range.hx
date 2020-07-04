/**
    A range is a 2-array of shape [min, max].

    No checks are done for the array size, so large arrays will silently work
    (the larger values ignored), and smaller arrays will result in runtime
    errors.
**/
abstract Range(Array<Float>) from Array<Float> to Array<Float> {
  public var min(get, set): Float;
  public var max(get, set): Float;

  static public final UNIT : Range = [0, 1];

  public inline function clamp(x: Float) : Float {
    if (x <= this[0]) { return this[0]; }
    else if (x >= this[1]) { return this[1]; }
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

  public inline function steps(steps: Int) : Iterator<Float> {
    return new RangeIterator(this, steps);
  }

  public inline function get_min() { return this[0]; }
  public inline function set_min(v) { return this[0] = v; }
  public inline function get_max() { return this[1]; }
  public inline function set_max(v) { return this[1] = v; }
}

class RangeIterator {
  private final range: Range;
  private final steps: Int;
  private var currentStep: Int;

  public function new(range: Range, steps: Int) {
    this.range = range;
    this.steps = steps;
    this.currentStep = 0;
  }

  public function hasNext() : Bool { return currentStep <= steps; }

  public function next() : Float {
    final val = range.lerp(currentStep/steps);
    currentStep++;
    return val;
  }
}
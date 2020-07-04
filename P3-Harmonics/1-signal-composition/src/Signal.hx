
/**
    Objects of this type represent a simple harmonic signal with a set
    frequency.
**/
class Signal {

  public var offset: Float;
  public var frequency: Float;

  public function new(offset: Float, frequency: Float) {
    this.offset = offset;
    this.frequency = frequency;
  }

  public function valueAt(x: Float): Float {
    return Math.sin(x*frequency + offset);
  }

  /**
      Compute an array of values for the signal.
  **/
  public function valuesFor(xs: Iterator<Float>): Array<Vector> {
    return [ for (x in xs) [x, valueAt(x)] ];
  }
}

abstract SignalSum(Array<Signal>) from Array<Signal> to Array<Signal> {
  public function valuesFor(xs: Iterator<Float>): Array<Vector> {
    return [
      for (x in xs) {
        var sum = 0.0;
        for (signal in this) {
          sum += signal.valueAt(x);
        }
        [x, sum];
      }
    ];
  }
}
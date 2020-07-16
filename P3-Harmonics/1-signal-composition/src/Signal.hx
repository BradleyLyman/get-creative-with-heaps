/**
  Objects of this type represent a simple harmonic signal with a set
  frequency.
**/
class Signal {
  public var offset:Float;
  public var frequency:Float;

  public function new(offset:Float, frequency:Float) {
    this.offset = offset;
    this.frequency = frequency;
  }

  public function eval(x:Float):Float {
    return Math.sin(x * frequency + offset);
  }
}

import haxe.Timer;

class Signal {
  public var frequency : Float;
  public var offset : Float;

  public function new(f: Float, o: Float) {
    this.frequency = f;
    this.offset = o;
  }

  public function eval(x: Float): Float {
    return Math.sin(offset + x*frequency);
  }
}

class Main {

  static public function main() {
    final signal = new Signal(1, 0);
    final count = 100000;
    var data: Array<Float> = [ for (i in 0...count) i ];


    var result;
    Timer.measure(() -> {
      for (i in 0...1000) {
        result = data.map(signal.eval);
      }
    });
    trace(result.length);
    trace(result[0] + result[result.length-1]);


    var data2 = new haxe.ds.Vector<Float>(count);
    var vresult = new haxe.ds.Vector<Float>(count);
    for (i in 0...data2.length) { data2[i] = i; }
    Timer.measure(() -> {
      for (i in 0...1000) {
        for (j in 0...data2.length) {
          vresult[j] = signal.eval(data2[j]);
        }
      }
    });
    trace(vresult.length);
    trace(vresult[0] + vresult[vresult.length-1]);
  }
}
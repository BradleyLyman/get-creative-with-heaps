package support;

/**
  Compute a rolling average frame time.
**/
class FrameTime {
  private final max:Int;
  private final name:String;
  private var times:Array<Float> = [];
  private var current:Int = 0;

  /* Create a new instance with max samples. */
  public function new(max:Int = 60, name:String = "FrameTime") {
    this.max = max;
    this.name = name;
  }

  /* Measure and record how log it takes to do some operation. */
  public function measure(f:() -> Void) {
    final start = haxe.Timer.stamp();
    f();
    final end = haxe.Timer.stamp();
    push(end - start);
  }

  /* Push a new value into the average list. */
  public function push(time:Float) {
    if (times.length < max) {
      times.push(time);
    } else {
      times[current] = time;
    }
    next();
  }

  /* Compute the average of the sums */
  public function average():Float {
    var sum = 0.0;
    for (time in times)
      sum += time;
    return sum / times.length;
  }

  /**
    Increment the current counter, roll over if the end is reached.
    Traces the time on each reset.
  **/
  private function next() {
    current++;
    if (current >= max) {
      current = 0;
      trace("Avg " + name + ": " + Math.ceil(average() * 1000) + "ms");
    }
  }
}

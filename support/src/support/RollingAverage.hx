/**
    Compute the rolling average of a list of numbers.;
**/
class RollingAverage {
  private final max;
  private var times : Array<Float> = [];
  private var current : Int = 0;

  public function new(max: Int = 60) {
    this.max = max;
  }

  public function push(time: Float) {
    if (times.length < max) {
      times.push(time);
    }
    else {
      times[current] = time;
    }
    next();
  }

  private function next() {
    current++;
    if (current >= max) {
      current = 0;
      trace("avg: " + Math.ceil(average() * 1000) + "ms");
    }
  }

  public function average() : Float {
    var sum = 0.0;
    for (time in times) sum += time;
    return sum / times.length;
  }
}
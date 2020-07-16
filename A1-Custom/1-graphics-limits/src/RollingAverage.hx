class RollingAverage {
  private final MAX_FRAMES = 60;
  private var times:Array<Float> = [];
  private var current:Int = 0;

  public function new() {}

  public function push(time:Float) {
    if (times.length < MAX_FRAMES) {
      times.push(time);
    } else {
      times[current] = time;
    }
    next();
  }

  private function next() {
    current++;
    if (current >= MAX_FRAMES) {
      current = 0;
      trace("avg: " + Math.ceil(average() * 1000) + "ms");
    }
  }

  public function average():Float {
    var sum = 0.0;
    for (time in times)
      sum += time;
    return sum / times.length;
  }
}

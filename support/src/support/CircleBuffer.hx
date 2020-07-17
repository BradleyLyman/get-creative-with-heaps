package support;

import haxe.ds.Vector;

class CircleBuffer<T> {
  private var cursor:Int;
  private var buffer:Vector<T>;

  public function new(init:T, maxLen:Int) {
    buffer = new Vector<T>(maxLen);
    cursor = 0;
    for (i in 0...buffer.length) {
      buffer[i] = init;
    }
  }

  public function push(val:T) {
    buffer[cursor] = val;
    inc();
  }

  public function iterator():Iterator<T> {
    return new NewToOldIterator<T>(this);
  }

  private function inc() {
    cursor = (cursor + 1) % buffer.length;
  }
}

class NewToOldIterator<T> {
  private var cb:CircleBuffer<T>;
  private var myCursor:Int;
  private var steps:Int;

  public function new(cb:CircleBuffer<T>) {
    @:privateAccess
    this.myCursor = cb.cursor;
    this.cb = cb;
    dec();
    steps = 0;
  }

  public function hasNext():Bool {
    // invalid if the cursor moves
    @:privateAccess
    return steps < cb.buffer.length;
  }

  public function next():T {
    @:privateAccess
    final val = cb.buffer[myCursor];
    dec();
    steps++;
    return val;
  }

  private function dec() {
    myCursor -= 1;
    if (myCursor < 0) {
      @:privateAccess
      myCursor = cb.buffer.length - 1;
    }
  }
}

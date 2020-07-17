package support;

import utest.Assert;

class CircleBufferTest extends utest.Test {
  function testPushThings() {
    final b = new CircleBuffer<Int>(2, 3);
    b.push(2);
    b.push(1);
    b.push(0);

    @:privateAccess
    trace(b.buffer + " | " + b.cursor);

    final i = b.iterator();

    Assert.isTrue(i.hasNext());
    Assert.equals(0, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(1, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(2, i.next());

    Assert.isFalse(i.hasNext());
  }

  function testPushLots() {
    final b = new CircleBuffer<Int>(-1, 5);

    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));

    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));
    b.push(Math.round((Math.random() * 200)));

    b.push(5);
    b.push(4);
    b.push(3);
    b.push(2);
    b.push(1);
    b.push(0);

    final i = b.iterator();

    Assert.isTrue(i.hasNext());
    Assert.equals(0, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(1, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(2, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(3, i.next());

    Assert.isTrue(i.hasNext());
    Assert.equals(4, i.next());

    Assert.isFalse(i.hasNext());
  }
}

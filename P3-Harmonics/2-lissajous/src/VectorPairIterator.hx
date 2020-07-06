import haxe.ValueException;
import haxe.ds.Vector;

class VectorPairIterator {
  final vector: Vector<Float>;
  var cursor: Int = 0;

  public inline function new(vector: Vector<Float>) {
    if (vector.length % 2 != 0) {
      throw new ValueException(
        "only even length vectors can be iterated in pairs"
      );
    }
    this.vector = vector;
  }

  public inline function hasNext(): Bool {
    return cursor < vector.length;
  }

  public inline function next(): Pair {
    final a = vector[cursor++];
    final b = vector[cursor++];
    return new Pair(a, b);
  }

  static public inline function pairs(vector: Vector<Float>) {
    return new VectorPairIterator(vector);
  }
}

class Pair {
  public final a: Float;
  public final b: Float;

  public inline function new(a: Float, b: Float) {
    this.a = a;
    this.b = b;
  }
}
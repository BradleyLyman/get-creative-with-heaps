package support.color;

/**
  The fundamental color type. Shaders and graphics hardware know how to handle
  RGBA colors directly, so RGBA is the common denominator for all other color
  types.
**/
class RGBA implements Color {
  public var r:Float;
  public var g:Float;
  public var b:Float;
  public var a:Float;

  /* Create a new rgba color. Defaults to white. */
  public inline function new(
    r:Float = 1.0,
    g:Float = 1.0,
    b:Float = 1.0,
    a:Float = 1.0
  ) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  /**
    Transform this color to a packed ARGB 32 bit integer.
    This is the format most of Heap's internals seem to expect when looking
    for a color integer.
    @return Int - a 32 bit integer packed with the ARGB color components
  **/
  public inline function toARGBInt():Int {
    final ri = Math.floor((r * 0xFF));
    final gi = Math.floor((g * 0xFF));
    final bi = Math.floor((b * 0xFF));
    final ai = Math.floor((a * 0xFF));
    return (ai << 24 | ri << 16 | gi << 8 | bi);
  }

  /* Return this color */
  public inline function toRGBA():RGBA {
    return this;
  }

  /* A new RGBA instance with the exact same rgba values */
  public inline function clone():RGBA {
    return new RGBA(r, g, b, a);
  }

  /* This color as a human-readable string. */
  public function toString() {
    return 'RGBA($r, $g, $b, $a)';
  }
}

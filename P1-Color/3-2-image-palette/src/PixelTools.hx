import haxe.io.Bytes;

class PixelTools {
  /**
      Treat a Pixels object like a list of sortable values. Sort them according
      to the provided function and return a pixels object with the same
      width and height.

      @param pixels
          The pixels to read. No changes happen to this object.
      @param greaterThan
          A function which compares two h3d.Vectors which represent the pixel
          a pixel Color.
      @return
          A new pixel instance with all values reorganized according to the
          greaterThan function.
  **/
  public static function toSorted(
    pixels: hxd.Pixels,
    greaterThan: (h3d.Vector, h3d.Vector) -> Bool
  ) : hxd.Pixels {
    pixels.convert(hxd.PixelFormat.BGRA);

    var pixelVec3ds = pixels.toVector().map(i -> h3d.Vector.fromColor(i));

    pixelVec3ds.sort((x, y) -> {
      if (greaterThan(x, y)) {
        return 1;
      } else {
        return -1;
      }
    });

    return new hxd.Pixels(
      pixels.width,
      pixels.height,
      pixelIntsToBytes(pixelVec3ds.map(v -> v.toColor())),
      hxd.PixelFormat.BGRA
    );
  }

  /**
      Convert a Vector of 32 bit ints into a Byte collection.

      This may seem like an odd approach (it did for me!). But the
      haxe.ds.Vector is a platform-specific type and it's not guaranteed to
      be a contigious block of memory. Hence the need to copy int for int into
      the returned bytes.

      This does mean that careful use of #if conditionals could yield a perf
      improvement by avoiding the uneeded copy and loop. But there's little
      evidince that *this* is a bottleneck which needs optimizing.
  **/
  private static function pixelIntsToBytes(ints: haxe.ds.Vector<Int>) : Bytes {
    final bytes = Bytes.alloc(ints.length * 4);
    var offset = 0;
    for (value in ints) {
      bytes.setInt32(offset, value);
      offset += 4;
    }
    return bytes;
  }
}
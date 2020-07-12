package support.color;

/**
    Objects of this type represent a color defined by it's hue, saturation,
    and lightness.

    There is an excellent breakdown of HSL color available on wikipedia
    https://en.wikipedia.org/wiki/HSL_and_HSV
**/
class HSL implements Color {

  /**
      The color's hue, in degrees from 0 - 360. Values outside that range are
      modulated.
  **/
  public var hue : Float;

  /**
      The color's saturation. Values should be in the range [0-1]

      - 0 means the color is completely washed out
      - 1 means the color is fully saturated
  **/
  public var saturation : Float;

  /**
      The color's lightness. Values should be in the range 0 - 1.

      - 0 means the color is entirely black
      - 1 means the color is entirely white
      - 0.5 is the pure color.
  **/
  public var lightness : Float;

  /**
      The color's transparency when rendered to the screen. Values should be
      in the range 0 - 1.
  **/
  public var alpha : Float;

  /* Create a new instance with the provided hue, saturation, and lightness */
  public inline function new(
    h: Float,
    s: Float = 1.0,
    l: Float = 0.5,
    a: Float = 1.0
  ) {
    this.hue = h;
    this.saturation = s;
    this.lightness = l;
    this.alpha = a;
  }

  /* Convert this color to an RGBA representation. */
  public function toRGBA(): RGBA {
    final C = saturation * (1.0 - Math.abs(2.0 * lightness - 1));
    final H = hue / 60.0;
    final X = C * (1 - Math.abs((H%2.0) - 1));
    final triple = switch (H) {
      case _ if (H >= 0 && H < 1): {r: C, g: X, b: 0}
      case _ if (H >= 1 && H < 2): {r: X, g: C, b: 0}
      case _ if (H >= 2 && H < 3): {r: 0, g: C, b: X}
      case _ if (H >= 3 && H < 4): {r: 0, g: X, b: C}
      case _ if (H >= 4 && H < 5): {r: X, g: 0, b: C}
      case _ if (H >= 5 && H < 6): {r: C, g: 0, b: X}
      default: {r: 0, g: 0, b: 0};
    };
    final m = lightness -  (C / 2.0);
    return new RGBA(triple.r + m, triple.g + m, triple.b + m, alpha);
  }
}
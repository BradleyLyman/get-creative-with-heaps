import support.color.HSL;
import support.turtle.Turtle;
import support.turtle.DecoratedTurtle;
import support.linAlg2d.Vec;

/**
    A line-drawing turtle which only emits a line when it is longer than some
    maximum length threshold.
**/
class MaxLengthTurtle extends DecoratedTurtle {
  final maxLength: Float;
  var start = 0;
  final hsl : HSL = new HSL();

  public function new(turtle: Turtle, maxLength: Float) {
    super(turtle);
    this.maxLength = maxLength;
    hsl.saturation = 1.0;
    hsl.lightness = 0.75;
  }

  public override function moveTo(x: Float, y: Float): MaxLengthTurtle {
    wrapped.moveTo(x, y);
    return this;
  }

  public override function lineTo(x: Float, y: Float) : MaxLengthTurtle {
    final d = new Vec(x, y).sub(this.position).len();
    if (d < maxLength) {
      start += 1;
      hsl.hue = start + (d/maxLength) * 60;
      hsl.alpha = (1.0 - (d / maxLength));
      wrapped.color = hsl;
      wrapped.lineTo(x, y);
    }
    else {
      moveTo(x, y);
    }
    return this;
  }
}
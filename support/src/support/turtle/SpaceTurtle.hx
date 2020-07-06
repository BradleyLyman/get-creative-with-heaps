package support.turtle;

import support.linAlg2d.Vec;
import support.linAlg2d.Space;

/**
    This turtle provides a mapping of input coordinates to some set of output
    coordinates according to a space.
**/
class SpaceTurtle extends DecoratedTurtle {
  public final space: Space = new Space();

  public override function moveTo(x: Float, y: Float): SpaceTurtle {
    wrapped.moveTo(space.mapX(x), space.mapY(y));
    return this;
  }

  public override function lineTo(x: Float, y: Float): SpaceTurtle {
    wrapped.lineTo(space.mapX(x), space.mapY(y));
    return this;
  }

  /* get the turtle's position in input space */
  override function get_position(): Vec {
    final wp = wrapped.position.clone();
    return new Vec(
      space.xIn.lerp(space.xOut.normalize(wp.x)),
      space.yIn.lerp(space.yOut.normalize(wp.y))
    );
  }

  /* set the turtle's position using a vector in the input space */
  override function set_position(v: Vec): Vec {
    moveTo(v.x, v.y);
    return v;
  }
}
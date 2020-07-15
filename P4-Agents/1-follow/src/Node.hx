import support.linAlg2d.Interval;
import support.turtle.Turtle;
import support.linAlg2d.Vec;

using support.turtle.VecTurtle;

/**
    A Node is a kinematic point mass with a position, velocity, and
    acceleration.
**/
class Node {
  public static var MAX_VEL : Float = 500;
  public static var MAX_ACC : Float = 500;
  public static var X_BOUND : Interval = new Interval(-500, 500);
  public static var Y_BOUND : Interval = new Interval(-500, 500);

  public var pos : Vec = [0, 0];
  public var vel : Vec = [0, 0];
  public var acc : Vec = [0, 0];

  public inline function new() {};

  /**
      Compute the node's position via the velocity and acceleration, assuming
      both are constant for the duration of dt.

      Acceleration resets to zero after each integration.
  **/
  public function integrate(dt: Float) {
    acc.limit(MAX_ACC);
    vel.limit(MAX_VEL);

    vel += acc*dt;
    pos += vel*dt;
    acc *= 0.0;

    pos.x = X_BOUND.clamp(pos.x);
    pos.y = Y_BOUND.clamp(pos.y);
  }

  /**
      Seek away from the screen's boundaries.
  **/
  public function bounds() {
    if (pos.x <= X_BOUND.lerp(0.05)) {
      seek([X_BOUND.end, pos.y], MAX_VEL);
    }
    else if (pos.x >= X_BOUND.lerp(0.95)) {
      seek([X_BOUND.start, pos.y], MAX_VEL);
    }

    if (pos.y <= Y_BOUND.lerp(0.05)) {
      seek([pos.x, Y_BOUND.end], MAX_VEL);
    }
    else if (pos.y >= Y_BOUND.lerp(0.95)) {
      seek([pos.x, Y_BOUND.start], MAX_VEL);
    }
  }

  /**
      Add to the node's acceleration vector to cause the node to move towards
      the provided point.
  **/
  public function seek(p: Vec, rate: Float = 200, slowRadius: Float = 200) {
    var idealVel = p - pos;
    final ratio = idealVel.len() / slowRadius;
    idealVel.norm();
    if (ratio < 1.0) {
      idealVel.scale(ratio * rate);
    }
    else {
      idealVel.scale(rate);
    }
    final steerForce = (idealVel - vel);
    acc += steerForce;
  }

  /* Use the provided turtle to render the node as triangle. */
  public function draw(turtle: Turtle, width: Float = 1) {
    final look: Vec = (vel.sqrLen() < 0.01) ? [0, 1] : vel.clone().norm();
    final lookRight = look.clone().rot90();

    final right = pos + lookRight*width*0.5;
    final left = pos - lookRight*width*0.5;
    final center = pos + look*width*2;

    turtle
      .moveToVec(left)
      .lineToVec(right)
      .lineToVec(center)
      .lineToVec(left)
      .lineToVec(right);
  }
}
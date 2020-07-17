import support.CircleBuffer;
import support.color.HSL;
import support.linAlg2d.Interval;
import support.turtle.Turtle;
import support.linAlg2d.Vec;

using support.turtle.VecTurtle;

/**
  A Node is a kinematic point mass with a position, velocity, and
  acceleration.
**/
class Node {
  public static var MAX_VEL:Float = 500;
  public static var MAX_ACC:Float = 500;
  public static var X_BOUND:Interval = new Interval(-500, 500);
  public static var Y_BOUND:Interval = new Interval(-500, 500);
  public static var MAX_TAIL_LEN:Int = 5;

  public var pos:Vec;
  public var vel:Vec = [0, 0];
  public var acc:Vec = [0, 0];
  public var whiskerAngle:Float = Math.random() * Math.PI * 2;
  public var tail:CircleBuffer<Vec>;

  private var tailCursor:Int = 0;
  private var rootColor:Float = Math.random() * 360;
  private var skipCount:Int = 0;

  public inline function new(pos:Vec) {
    this.pos = pos;
    tail = new CircleBuffer<Vec>(pos, MAX_TAIL_LEN);
  };

  /**
    Compute the node's position via the velocity and acceleration, assuming
    both are constant for the duration of dt.

    Acceleration resets to zero after each integration.
  **/
  public function integrate(dt:Float) {
    acc.limit(MAX_ACC);
    vel.limit(MAX_VEL);

    skipCount++;
    if (skipCount > 6) {
      tail.push(pos);
      skipCount = 0;
    }

    vel += acc * dt;
    pos += vel * dt;
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
    } else if (pos.x >= X_BOUND.lerp(0.95)) {
      seek([X_BOUND.start, pos.y], MAX_VEL);
    }

    if (pos.y <= Y_BOUND.lerp(0.05)) {
      seek([pos.x, Y_BOUND.end], MAX_VEL);
    } else if (pos.y >= Y_BOUND.lerp(0.95)) {
      seek([pos.x, Y_BOUND.start], MAX_VEL);
    }
  }

  /**
    Add to the node's acceleration vector to cause the node to move towards
    the provided point.
  **/
  public function seek(p:Vec, rate:Float = 200, slowRadius:Float = 200) {
    var idealVel = p - pos;
    final ratio = idealVel.len() / slowRadius;
    idealVel.norm();
    if (ratio < 1.0) {
      idealVel.scale(ratio * rate);
    } else {
      idealVel.scale(rate);
    }
    final steerForce = (idealVel - vel);
    acc += steerForce;
  }

  /* Use the provided turtle to render the node as triangle. */
  public function draw(turtle:Turtle, width:Float = 8) {
    final look:Vec = (vel.sqrLen() < 0.01) ? [0, 1] : vel.clone().norm();
    turtle.color = new HSL(rootColor, 1.0, 0.5);
    turtle.moveToVec(pos).lineToVec(pos + look * width);
  }

  public function drawTail(turtle:Turtle, width:Float = 4) {
    final hsl = new HSL(rootColor, 1.0, 0.5);
    final ogc = turtle.color;

    var count = 1;
    turtle.color = hsl;
    turtle.moveToVec(pos);
    for (p in tail) {
      final norm = (count++) / MAX_TAIL_LEN;
      hsl.lightness = lerp(norm, 0.8, 0.1);
      hsl.alpha = lerp(norm, 1, 0.5);
      turtle.lineWidth = lerp(norm, width / 4, width);
      turtle.lineToVec(p);
    }

    turtle.color = ogc;
  }

  private function lerp(t:Float, min:Float, max:Float):Float {
    return (1.0 - t) * min + t * max;
  }
}

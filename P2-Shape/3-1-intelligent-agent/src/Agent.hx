import h2d.Graphics;
import hxd.Pixels;

/**
  Objects of this class represent 'intelligent' agents which draw lines.

  Agents paint a stright line from the initial position until they strike
  the side of the screen or another already existing line. The line thickness
  and transparency depneds on the length of the line.
**/
class Agent {
  private var lastPosition:Vector;
  private var position:Vector;
  private var lastBounce:Vector;

  private var angle:Float;
  private var direction:Vector;

  private var color:Int;

  private final MIN_LENGTH = 20;

  /**
    Create a new agent at a random position on the screen with the provided
    color.
  **/
  public function new(color:Int) {
    this.color = color;
    final window = hxd.Window.getInstance();
    angle = Math.random() * Math.PI / 2;
    position = lastPosition = lastBounce = [window.width * Math.random(), window.height * Math.random()];
    randomDirection();
  }

  /**
    The agent takes a step in it's current direction.

    If the agent bounces from the side of the screen or crosses a previous
    line then a line is emitted and a new direction is selected.
  **/
  public function step(size:Float, graphics:Graphics, lastFrame:Pixels) {
    lastPosition = position;
    position = position + size * direction;
    if (enforceBounds() || crossedAnyLines(lastFrame)) {
      emitLine(graphics);
      randomDirection();
      position = position + size * direction;
      lastPosition = position;
      lastBounce = position;
    }
  }

  private function emitLine(graphics:h2d.Graphics) {
    final len = (lastBounce - position).length();
    if (len < MIN_LENGTH) {
      return;
    } // don't render short lines

    final normLen = len / 500;
    final lineWidth = 1 + normLen * 4;
    final lineTrans = 0.6 + (normLen * 2) * 0.4;

    graphics.beginFill(color, lineTrans);
    graphics.lineStyle(lineWidth, color, lineTrans);
    graphics.moveTo(lastBounce.x, lastBounce.y);
    graphics.lineTo(position.x, position.y);
    graphics.endFill();
  }

  /* Keep the agent within the window's bounds. */
  private function enforceBounds():Bool {
    final window = hxd.Window.getInstance();
    final clampedX = clamp(position.x, 0, window.width);
    final clampedY = clamp(position.y, 0, window.height);
    position.x = clampedX.at;
    position.y = clampedY.at;
    return !(clampedX.inRange && clampedY.inRange);
  }

  /**
    Clamp a value to a specified range, return a flag to indicate if value
    was already in the range
  **/
  private function clamp(a:Float, start:Float, end:Float) {
    if (a <= start) {
      return {at: start, inRange: false};
    } else if (a >= end) {
      return {at: end, inRange: false};
    } else {
      return {at: a, inRange: true};
    }
  }

  /**
    A heuristic function to determined if the agent has crossed a line since
    the last frame. This is more of a heuristic than a true collision
    detection because it attempts to check every pixel the agent crossed
    betwen this and the last frame. The attempt is pretty coarse so it's
    possible to miss things.
  **/
  private function crossedAnyLines(pixels:hxd.Pixels):Bool {
    // if the current position is colored, then the agent is over a line
    if (pixelAt(position, pixels) != 0x000000) {
      return true;
    }

    // take steps of length 1 (roughly 1 pixel, depending on the angle)
    // and check the pixel at each position
    final line = position - lastPosition;
    final len = line.length();
    final dir = line * (1 / len);
    for (i in 1...Math.floor(len)) {
      final p = lastPosition + dir * i;
      if (pixelAt(p, pixels) != 0x000000) {
        return true;
      }
    }

    // nothing was colored, so the agent must not be over a past line
    return false;
  }

  /* Get the pixel value at location v. Rounds to the closest int. */
  private function pixelAt(v:Vector, pixels:hxd.Pixels):Int {
    return pixels.getPixel(Math.round(v.x), Math.round(v.y));
  }

  /* Render the agent's current position as a small dot. */
  public function render(graphics:h2d.Graphics) {
    graphics.beginFill(color);
    graphics.drawCircle(position.x, position.y, 2, 8);
    graphics.endFill();

    graphics.lineStyle(1, 0xFFFFFF, 1.0);
    graphics.moveTo(lastBounce.x, lastBounce.y);
    graphics.lineTo(position.x, position.y);
  }

  /* Pick a new random direction. */
  private function randomDirection() {
    final norm = (Math.random() * 2) - 1.0; // a random number between [-1, 1];
    final sign = norm / Math.abs(norm); // the sign of our random number
    final offset = sign * (Math.PI / 8) + norm * (Math.PI / 4);

    angle += Math.PI; // turn 180 degrees
    angle += offset; // add the random angle offset

    // compute the unit direction vector based on the angle
    direction = [Math.cos(angle), Math.sin(angle)];
  }
}

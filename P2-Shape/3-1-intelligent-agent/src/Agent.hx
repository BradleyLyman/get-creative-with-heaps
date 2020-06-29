 enum Cardinal { North; South; East; West; }

 class Agent {
  private var lastBounce : Vector;
  private var position : Vector;
  private var bounds : { width: Float, height: Float };
  private var direction : Vector;
  private var cardinal : Cardinal = Cardinal.North;
  private var intersections : Array<Vector> = [];

  private static var lines : Array<{start: Vector, end: Vector}> = [];

  public function new(
    x: Float, y: Float,
    screenWidth: Float, screenHeight: Float
  ) {
    position = [x, y];
    lastBounce = position;
    bounds = { width: screenWidth, height: screenHeight };
    randomDirection();
  }

  public function onResize(screenWidth : Float, screenHeight: Float) {
    bounds = {width: screenWidth, height: screenHeight};
    lines = [];
  }

  public function step(size: Float) {
    position = position + size*direction;
    if (enforceBounds() || anyCross()) {
      if ((lastBounce - position).length() > 20) {
        lines.push({start: lastBounce, end: position});
      }
      randomDirection();
      lastBounce = position + size*direction;
    }

    if (lines.length > 10000) {
    }
  }

  private function enforceBounds() : Bool {
    var enforced = false;
    if (position.x <= 0) {
      enforced = true;
      position.x = 0;
    }
    else if (position.x >= bounds.width) {
      enforced = true;
      position.x = bounds.width;
    }

    if (position.y <= 0) {
      enforced = true;
      position.y = 0;
    }
    else if (position.y >= bounds.height) {
      enforced = true;
      position.y = bounds.height;
    }
    return enforced;
  }

  private function anyCross() : Bool {
    final current = {start: lastBounce, end: position};
    for (line in lines) {
      if (intersect(current, line)) {
        return true;
      }
    }
    return false;
  }

  private function intersect(
    A: {start: Vector, end: Vector},
    B: {start: Vector, end: Vector}
  ) : Bool {
    final Abar = A.end - A.start;
    final Bbar = B.end - B.start;

    final div = (Abar.x * Bbar.y) - (Abar.y * Bbar.x);
    if (Math.abs(div) <= 0.05) { return false; }

    final u_top =
      ((B.start.x - A.start.x)*Abar.y) -
      ((B.start.y - A.start.y)*Abar.x);
    final u = u_top / div;

    final t_top =
      ((B.start.x - A.start.x)*Bbar.y) -
      ((B.start.y - A.start.y)*Bbar.x);
    final t = t_top / div;

    if (
      (u > 0 && u < 1) &&
      (t > 0 && t < 1)
    ) {
      intersections.push(B.start + u*(B.end - B.start));
      return true;
    }

    return false;
  }

  public function render(graphics: h2d.Graphics) {
    graphics.beginFill(0x4444FF, 1.0);
    graphics.lineStyle(1, 0x4444FF);
    graphics.drawRect(position.x - 4, position.y - 4, 8, 8);
    graphics.endFill();
  }

  public static function renderLines(graphics: h2d.Graphics, maxLen: Float) {
    for (line in lines) {
      final length = (line.start - line.end).length();
      final normed = length / maxLen;
      final lineWidth = 20 * normed;

      graphics.lineStyle(lineWidth, 0xFFFFFF, 0.75);
      graphics.moveTo(line.start.x, line.start.y);
      graphics.lineTo(line.end.x, line.end.y);
    }
  }

  private function randomDirection() {
    cardinal = switch (cardinal) {
      case North: South;
      case South: North;
      case East: West;
      case West: East;
    };

    final root = switch(cardinal) {
      case West: 0;
      case East: Math.PI;
      case North: Math.PI/2;
      case South: 3.0 * Math.PI/2;
    };

    final segments : Int = 5;
    final increment : Float = (Math.PI/2) / (segments+1);

    final randNorm = -1 + Math.random()*2.0;
    final rootOffset = 1 + Math.round(randNorm * (segments-1));

    final angle = root + (rootOffset * increment);
    direction = [Math.cos(angle), Math.sin(angle)];
  }
}
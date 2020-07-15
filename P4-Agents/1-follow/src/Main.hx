import hxd.Event;
import hxd.Window;
import support.h2d.Plot;

using support.turtle.VecTurtle;

class Main extends hxd.App {
  var plot: Plot;
  var nodes: Array<Node> = [];

  override function init() {
    plot = new Plot(s2d);
    plot.turtle.lineWidth = 2;
    plot.xAxis = Node.X_BOUND;
    plot.yAxis = Node.Y_BOUND;

    new support.h2d.FullscreenButton(s2d);

    Window.getInstance().addEventTarget(handleEvent);

    onResize();
  }

  function handleEvent(e: Event) {
    if (e.kind == EPush) {
      final n = new Node();
      n.pos = plot.mousePos() + [0.1, 0.1];
      nodes.push(n);
    }
  }

  override function onResize() {
    final size = Math.min(s2d.width, s2d.height);
    plot.resize(size, size);
    plot.x = (s2d.width - size) / 2;
    plot.y = (s2d.height - size) / 2;
  }

  override function update(dt: Float) {
    plot.clear();
    final mouse = plot.mousePos();
    for (node in nodes) {
      node.seek(mouse, 100, 100);
      node.draw(plot.turtle, 4);
      node.integrate(dt);
    }
  }

  static function main() { new Main(); }
}
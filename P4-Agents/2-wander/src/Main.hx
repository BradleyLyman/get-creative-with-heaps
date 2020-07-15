import support.color.HSL;
import haxe.PosInfos;
import support.linAlg2d.Vec;
import hxd.Res;
import h2d.Interactive;
import support.h2d.ui.NamedSlider;
import support.h2d.ui.BasicControls;
import support.h2d.Plot;

using support.turtle.VecTurtle;

class Main extends hxd.App {
  var plot: Plot;
  var plotInteractive: Interactive;

  var nodes: Array<Node> = [];

  var force: NamedSlider;
  var size: NamedSlider;

  var whisker: NamedSlider;
  var speed: NamedSlider;
  var radius: NamedSlider;

  override function init() {
    plot = new Plot(s2d);
    plot.turtle.lineWidth = 2;
    plot.xAxis = Node.X_BOUND;
    plot.yAxis = Node.Y_BOUND;
		plotInteractive = new Interactive(1, 1, plot);
    plotInteractive.onClick = (_) -> addNode();

    final cp = new BasicControls(s2d, Res.fonts.NotoSans32.toFont());
    cp.backgroundColor = new HSL(240, 0.4, 0.75, 0.25);
    cp.addText("== critter properties ==");
    size = cp.addSlider("critter size", 2, 32);
    force = cp.addSlider("force", 0, 500);

    cp.addText("== whisker properties ==");
    whisker = cp.addSlider("visibility", 0, 1);
    radius = cp.addSlider("wiggle", 0, 100);
    speed = cp.addSlider("length", 0, 100);

    force.value = 250;
    speed.value = 50;
    radius.value = 40;
    size.value = 8;
    whisker.value = 0.25;

    new support.h2d.FullscreenButton(s2d);

    onResize();
  }

  function addNode() {
    final n = new Node();
    n.pos = plot.mousePos() + [0.1, 0.1];
    n.vel = Vec.ofPolar(Math.random()*Math.PI*2, force.value);
    nodes.push(n);
  }

  override function onResize() {
    final size = Math.min(s2d.width, s2d.height);
    plot.resize(size, size);
    plotInteractive.width = plotInteractive.height = size;
    plot.x = (s2d.width - size) / 2;
    plot.y = (s2d.height - size) / 2;
  }

  override function update(dt: Float) {
    plot.clear();
    final c = plot.turtle.color;
    plot.turtle.color = new HSL(200, 1, 0.7, whisker.value);
    plot.turtle.lineWidth = 1;
    stepAgents(dt);
    plot.turtle.color = c;

    plot.turtle.lineWidth = 3;
    for (node in nodes) {
      node.draw(plot.turtle, size.value);
    }
  }

  private function stepAgents(dt: Float) {
    for (node in nodes) {
      final p = pointToSeek(node, speed.value, radius.value);
      node.seek(p, force.value, 50);
      node.bounds();
      node.integrate(dt);
    }
  }

  private function pointToSeek(node: Node, speed: Float, radius: Float): Vec {
    node.whiskerAngle += (Math.random()*2 - 1)*Math.PI/8;
    final look = node.vel.clone().norm();
    final posOffset = look*speed + node.pos;
    final target = posOffset + Vec.ofPolar(node.whiskerAngle, radius);
    plot.turtle
      .moveToVec(node.pos)
      .lineToVec(posOffset)
      .lineToVec(target);
    return target;
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}
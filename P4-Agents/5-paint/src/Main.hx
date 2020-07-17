import support.linAlg2d.Vec;
import hxd.Res;
import h2d.Interactive;
import support.h2d.Plot;

class Main extends hxd.App {
  var canvas:Canvas;
  var cplot:Plot;
  var plot:Plot;
  var plotInteractive:Interactive;

  var nodeInd:Int = 0;
  var nodes:Array<Node> = [];

  var force:Float;
  var size:Float;
  var whisker:Float;
  var wiggle:Float;
  var length:Float;

  override function init() {
    canvas = new Canvas(s2d);
    cplot = new Plot(canvas.root);
    plot = new Plot(s2d);
    plotInteractive = new Interactive(1, 1, plot);
    new support.h2d.FullscreenButton(s2d);

    cplot.xAxis = plot.xAxis = Node.X_BOUND;
    cplot.yAxis = plot.yAxis = Node.Y_BOUND;
    plotInteractive.onClick = (_) -> {
      for (i in 0...5) {
        addNode();
      }
    }

    force = 300;
    length = 50;
    wiggle = Math.PI / 8;
    size = 10;
    whisker = 25;

    onResize();

    for (i in 0...50) {
      addNode();
    }
  }

  function addNode() {
    final n = new Node(plot.mousePos());
    n.vel = Vec.ofPolar(Math.random() * Math.PI * 2, force);
    if (nodes.length < 400) {
      nodes.push(n);
    } else {
      nodes[nodeInd] = n;
    }
    nodeInd = (nodeInd + 1) % nodes.length;
  }

  override function onResize() {
    final size = Math.min(s2d.width, s2d.height);
    plot.resize(size, size);
    cplot.resize(size, size);
    plotInteractive.width = plotInteractive.height = size;
    cplot.x = plot.x = (s2d.width - size) / 2;
    cplot.y = plot.y = (s2d.height - size) / 2;
  }

  override function update(dt:Float) {
    plot.clear();
    cplot.clear();

    stepAgents(dt);

    plot.turtle.lineWidth = 4;
    for (node in nodes) {
      node.draw(plot.turtle);
      node.drawTail(cplot.turtle, size);
    }

    canvas.update();
  }

  private function stepAgents(dt:Float) {
    for (node in nodes) {
      final p = pointToSeek(node, length, length * 0.75);
      node.seek(p, force, 50);
      node.bounds();
      node.integrate(dt);
    }
  }

  private function pointToSeek(node:Node, speed:Float, radius:Float):Vec {
    node.whiskerAngle += (Math.random() * 2 - 1) * wiggle;
    final look = node.vel.clone().norm();
    final posOffset = look * speed + node.pos;
    final target = posOffset + Vec.ofPolar(node.whiskerAngle, radius);
    return target;
  }

  static function main() {
    Res.initEmbed();
    new Main();
  }
}

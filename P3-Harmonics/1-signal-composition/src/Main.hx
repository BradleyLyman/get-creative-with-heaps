import h3d.impl.Benchmark;
import h2d.Console.ConsoleArg;
import h2d.Font;
import h2d.Object;
import h2d.Slider;
import h2d.Text;
import h2d.Flow;

class Main extends hxd.App {
  var time = 0.0;

  var flow : Flow;

  var graphs : Array<{signal: Signal, plot: Plot}> = [];
  var total : Plot;
  var benchNext = false;

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
    flow = new Flow(s2d);
    flow.horizontalAlign = Middle;
    flow.verticalAlign = Middle;
    flow.layout = Vertical;

    total = new Plot([0, Math.PI*4], [-1.1, 1.1], flow);
    final range = total.axis.x.subdivide(1000);
    total.data = { x: range, y: range.map((x) -> 0.0) };
    onResize();

    new support.h2d.FullscreenButton(s2d);

    hxd.Window.getInstance().addEventTarget((e) -> {
      if (e.kind == EPush) { onClick(e); }
    });

  }

  function onClick(e: hxd.Event) {
    if (e.button == 0) { addGraph(); }
    else { removeGraph(); }
    onResize();
    benchNext = true;
  }

  override function onResize() {
    final height = 100 / (graphs.length + 3);
    for (graph in graphs) {
      graph.plot.resize(90*vw(), height*vh());
      graph.plot.render();
    }
    total.resize(90*vw(), height*2*vh());
    total.render();

    flow.minWidth = flow.maxWidth = s2d.width;
    flow.minHeight = flow.maxHeight = s2d.height;
    flow.reflow();
  }

  function addGraph() {
    if (graphs.length >= 5) { return; }

    final plot = new Plot([0, Math.PI*4], [-1.1, 1.1], flow);
    plot.data = { x: total.data.x, y: total.data.x.map((x) -> 0.0) };

    final minSignal = 0.5;
    final max = 15 * Math.random();
    graphs.push({
      signal: new Signal(0.0, max),
      plot: plot
    });
    total.axis.y = [-graphs.length-0.1, graphs.length+0.1];
  }

  function removeGraph() {
    if (graphs.length == 0) return;
    final graph = graphs.pop();
    graph.plot.dispose();
    total.axis.y = [-graphs.length-0.1, graphs.length+0.1];
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
    for (j in 0...total.data.x.length) { total.data.y[j] = 0; }
    for (graph in graphs) {
      graph.signal.offset += dt*2;
      for (j in 0...total.data.x.length) {
        final y = graph.signal.eval(total.data.x[j]);
        graph.plot.data.y[j] = y;
        total.data.y[j] += y;
      }
    }

    for (graph in graphs) { graph.plot.render(); }
    total.render();
  }

  function vw() : Int { return Math.round(s2d.width / 100.0); }
  function vh() : Int { return Math.round(s2d.height / 100.0); }
  function vm() : Int { return Math.round(Math.min(vw(), vh())); }

  static function main() {
    new Main();
  }
}
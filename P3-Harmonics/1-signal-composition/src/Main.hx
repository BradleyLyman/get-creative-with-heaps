import support.h2d.Plot;
import support.linAlg2d.Interval;

import hxd.Key;
import h2d.Flow;

class Main extends hxd.App {

  /**
      Flows are useful for automatically organizing and aligning elements on the
      screen.
  **/
  var flow: Flow;

  /* A plot to show the total sum of all signals in the harmonic plots */
  var total: Plot;

  /**
      A collection of signals and their plots, used to generate the total and
      show how a complex signal can be built from simple components.
  **/
  var harmonics: Array<{plot: Plot, signal: Signal}> = [];

  /**
      Create the flow and plots.
  **/
  override function init() {
    flow = new Flow(s2d);
    flow.horizontalAlign = Middle;
    flow.verticalAlign = Top;
    flow.layout = Vertical;
    flow.verticalSpacing = 4;

    flow.addSpacing(25);

    total = new Plot(flow);
    total.yAxis = new Interval(-1, 1);
    total.xAxis = new Interval(0, Math.PI*4);
    total.turtle.lineWidth = 2;

    addHarmonic();

    new support.h2d.FullscreenButton(s2d);
    hxd.Window.getInstance().addEventTarget(onKeyUp);

    onResize();
  }

  /* handle a window event, add and remove plots on key release */
  function onKeyUp(e: hxd.Event) {
    if (e.kind != EKeyUp) { return; }
    switch (e.keyCode) {
      case Key.UP: addHarmonic();
      case Key.DOWN: removeHarmonic();
      default: //
    }
  }

  /* Add a new harmonic component to the total. */
  function addHarmonic() {
    if (harmonics.length > 10) { return; } // skip if we already have 10

    // create the plot, set the scale and visual properties
    final plot = new Plot(flow);
    plot.xAxis = new Interval(0, Math.PI*4);
    plot.yAxis = new Interval(-1, 1);
    plot.turtle.lineWidth = 2;

    // create a new signal with some randomized fields
    final signal = new Signal(
      Math.random()*Math.PI*2,
      1 + Math.random()*(harmonics.length + 1)
    );

    harmonics.push({plot: plot, signal: signal});
    onResize();
  }

  /* Remove the last harmonic component from the total */
  function removeHarmonic() {
    if (harmonics.length == 0) { return; } // skip if there's nothing to remove

    // Remove the visual plot from the flow
    final harmonic = harmonics.pop();
    flow.removeChild(harmonic.plot);
    flow.needReflow = true;

    onResize();
  }

  /**
      Update flow bounds and flag the contents to be reflowed, resize each
      plot so there's enough space for each of them on screen.
  **/
  override function onResize() {
    flow.maxWidth = flow.minWidth = s2d.width;
    flow.maxHeight = flow.minHeight = s2d.height;
    flow.needReflow = true;

    final plotWidth = s2d.width * 0.9;
    final totalHeight = s2d.height / 4;
    total.resize(plotWidth, totalHeight );

    final count = (harmonics.length + 2);
    final harmonicHeight = (s2d.height - totalHeight) / count;
    for (harmonic in harmonics) {
      harmonic.plot.resize(plotWidth, harmonicHeight);
    }
  }

  /**
      Plot each signal. Each plot's xAxis advances with time to give a view
      of how each signal changes with time.
  **/
  override function update(dt: Float) {
    final rdt = dt * Math.PI/2; // advance 1/4 of cycle per second
    for (harmonic in harmonics) {
      harmonic.signal.offset += rdt;
      plotFunction(harmonic.plot, harmonic.signal.eval);
    }

    plotFunction(total, composedSignal);
  }

  private function plotFunction(plot: Plot, f: (x: Float) -> Float) {
    plot.clear();
    plot.turtle.moveTo(plot.xAxis.start, f(plot.xAxis.start));
    for (x in plot.xAxis.subdivide(500)) {
      plot.turtle.lineTo(x, f(x));
    }
  }

  /**
      The composed signal is just the sum of all contributing signals at each
      point.
  **/
  function composedSignal(x: Float): Float {
    final len = harmonics.length;
    var sum = 0.0;
    for (harmonic in harmonics) {
      // scale each signal to the sum still has max in the range [-1, 1]
      sum += (1.0/len) * harmonic.signal.eval(x);
    }
    return sum;
  }

  static function main() { new Main(); }
}
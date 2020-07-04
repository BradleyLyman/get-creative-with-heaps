import Signal.SignalSum;
import h2d.Slider;
import h2d.Text;

class Main extends hxd.App {

  var time = 0.0;

  /* The raw signal plots + sliders to change frequency. */
  var displays: Array<{
    plot: Plot,
    slider: Slider,
    signal: Signal
  }>;

  var total: {
    plot: Plot,
    signal: SignalSum
  }

  /**
      Initialize the demo. This is automatically called by Heaps when
      the window is ready.
  **/
  override function init() {
    new FullscreenButton(s2d);

    displays = [
      for (freq in 0...3) {
        {
          plot: new Plot(10, 10, [0, Math.PI*4], [-1.1, 1.1], s2d),
          slider: new Slider(10, 10, s2d),
          signal: new Signal(0.0, freq)
        };
      }
    ];
    total = {
      plot: new Plot(10, 10, [0, Math.PI*4], [-3.1, 3.1], s2d),
      signal: [ for (display in displays) display.signal ]
    };

    for (display in displays) {
      display.slider.rotate(Math.PI/2);
      display.slider.minValue = 0.25;
      display.slider.maxValue = 10.0;
      display.slider.value = display.signal.frequency;

      display.slider.onChange = () -> {
        display.signal.frequency = display.slider.value;
        display.plot.data =
          display.signal.valuesFor(display.plot.axis.x.steps(500));
        display.plot.render();

        total.plot.data = total.signal.valuesFor(total.plot.axis.x.steps(500));
        total.plot.render();
      };
      display.slider.onChange();
    }

    onResize();
  }

  override function onResize() {
    var count = 0;
    var offset: Vector = [0.0, s2d.height/5];
    for (display in displays) {
      place(display.plot, display.slider, offset * count++);
    }
    placeTotal(offset*count);
  }

  private function placeTotal(offset: Vector) {
    final margin: Vector = [0.1, 0.1];
    final plotPos = offset + [margin.x * s2d.width, margin.y * s2d.height];
    final plotDim: Vector = [s2d.width * (1.0-margin.x*2), s2d.height * (1/6)];
    total.plot.resize(plotDim.x, plotDim.y);
    total.plot.x = plotPos.x;
    total.plot.y = plotPos.y;
    total.plot.render();
  }

  private function place(plot: Plot, slider: Slider, offset: Vector) {
    final margin: Vector = [0.1, 0.1];
    final plotPos = offset + [margin.x * s2d.width, margin.y * s2d.height];
    final plotDim: Vector = [s2d.width * (1.0-margin.x*2), s2d.height * (1/6)];
    plot.resize(plotDim.x, plotDim.y);
    plot.x = plotPos.x;
    plot.y = plotPos.y;
    plot.render();

    slider.width = plotDim.y;
    slider.height = plotDim.y / 6;
    slider.x = plotPos.x - slider.height*0.1;
    slider.y = plotPos.y;
  }

  /**
      Update the contents of the screen.
      This is automatically called by Heaps before each frame.
  **/
  override function update(dt: Float) {
    time += dt*2;
    for (display in displays) {
      display.signal.offset = time;
      display.plot.data =
        display.signal.valuesFor(display.plot.axis.x.steps(500));
      display.plot.render();
    }
    total.plot.data = total.signal.valuesFor(total.plot.axis.x.steps(500));
    total.plot.render();
  }

  static function main() {
    new Main();
  }
}
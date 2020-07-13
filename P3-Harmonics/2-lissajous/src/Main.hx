import support.color.HSL;
import support.h2d.Plot;
import support.h2d.FullscreenButton;
import support.linAlg2d.Interval;

class Main extends hxd.App {
  final domain: Interval = new Interval(0, Math.PI*2);

  var plot: Plot;
  var tvals: haxe.ds.Vector<Float>;
  var time: Float = 0.0;

  var cp : BasicControls;
  var f1 : NamedSlider;
  var f2 : NamedSlider;

  override function init() {
    plot = new Plot(s2d);
    setupControlPanel();
    new FullscreenButton(s2d);

    plot.xAxis = new Interval(-1, 1);
    plot.yAxis = new Interval(-1, 1);

    onResize();
  }

  private function setupControlPanel() {
    final notoSans = hxd.Res.fonts.NotoSans16.toFont();
    cp = new BasicControls(s2d, notoSans);
    cp.backgroundColor = new HSL(260, 0.25, 0.25, 0.75);

    cp.addText("== signal frequencies ==");
    f1 = cp.addSlider("f1", 0.5, 5);
    f2 = cp.addSlider("f2", 0.5, 5);
    f1.value = 2.1;
    f2.value = 1.3;

    cp.addText("== sample domain ==");
    final divisions = cp.addSlider("subdivisions", 20, 150);
    divisions.value = 100;
    divisions.onChange = () -> {
      tvals = domain.subdivide(Math.round(divisions.value));
    };
    divisions.onChange();

    final max = cp.addSlider("end", Math.PI, Math.PI * 4);
    max.value = Math.PI * 2;
    max.onChange = () -> {
      domain.end = max.value;
      tvals = domain.subdivide(Math.round(divisions.value));
    };
  }

  override function onResize() {
    final side = Math.min(s2d.width, s2d.height) * 0.95;
    plot.resize(side, side);
    plot.x = (s2d.width - side) / 2.0;
    plot.y = (s2d.height - side) / 2.0;
  }

  override function update(dt: Float) {
    final speed = 0.5 * (Math.PI / 4);
    if (!cp.visible) time += dt*speed;
    final xSignal = (t: Float) -> Math.cos(time + t*f1.value);
    final ySignal = (t: Float) -> Math.sin(time + t*f2.value);

    plot.clear();
    final maxLenTurtle = new MaxLengthTurtle(plot.turtle, 0.5);
    for (i in tvals) {
      for (j in tvals) {
        maxLenTurtle
          .moveTo(xSignal(i), ySignal(i))
          .lineTo(xSignal(j), ySignal(j));
      }
    }
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
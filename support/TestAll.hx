import utest.Runner;
import utest.ui.Report;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new support.linAlg2d.VecTest());
    runner.addCase(new support.linAlg2d.IntervalTest());
    runner.addCase(new support.linAlg2d.SpaceTest());
    runner.addCase(new support.turtle.SpaceTurtleTest());
    runner.addCase(new support.turtle.DecoratedTurtleTest());
    runner.addCase(new support.color.RGBATest());
    runner.addCase(new support.color.HSLTest());
    Report.create(runner);
    runner.run();
  }
}

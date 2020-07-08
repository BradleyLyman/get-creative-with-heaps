import utest.Runner;
import utest.ui.Report;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new support.linAlg2d.VecTest());
    runner.addCase(new support.turtle.DecoratedTurtleTest());
    Report.create(runner);
    runner.run();
	}
}
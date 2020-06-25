import h2d.Scene.ScaleMode;
import h2d.Scene.ScaleModeAlign;

typedef Style = { weight: Int, color: Int, alpha: Float };

class Main extends hxd.App {

    var graphics : h2d.Graphics;

    /* The size, in pixels, for each grid cell. */
    var gridSize : Int = 20;

    override function init() {
        graphics = new h2d.Graphics(s2d);
        hxd.Window.getInstance().addEventTarget(onEvent);
    }

    function onEvent(event: hxd.Event) {
        switch (event.kind) {
            case ERelease:
                renderGrid(pickLRColors());
            default: // do nothing
        }
    }

    function pickLRColors() {
        final normalized = {
            x: s2d.mouseX / s2d.width,
            y: s2d.mouseY / s2d.height,
        };
        final hue = Math.random() * 2 * Math.PI;
        return {
            left: {
                alpha: 0.5,
                color: colorFor(hue),
                weight: 1 + normalized.x * 19,
            },
            right: {
                alpha: 0.5,
                color: colorFor(hue + Math.PI),
                weight: 1 + normalized.y * 19,
            }
        };
    }

    function renderGrid(styles) {
        final rows = Math.ceil(s2d.height / gridSize);
        final columns = Math.ceil(s2d.width / gridSize);

        var diagonals = [
            for (x_index in 0...columns) {
                for (y_index in 0...rows) {
                    final left = x_index * gridSize;
                    final right = (x_index+1) * gridSize;
                    final top = y_index * gridSize;
                    final bottom = (y_index+1) * gridSize;

                    if (Math.random() >= 0.5) {
                        {
                            start: {x: left, y: top},
                            end: {x: right, y: bottom},
                            style: styles.left
                        }
                    }
                    else {
                        {
                            start: {x: right, y: top},
                            end: {x: left, y: bottom},
                            style: styles.right
                        }
                    }
                }
            }
        ];

        graphics.clear();
        for (line in diagonals) {
            graphics.lineStyle(
                line.style.weight,
                line.style.color,
                line.style.alpha
            );
            graphics.moveTo(line.start.x, line.start.y);
            graphics.lineTo(line.end.x, line.end.y);
        }
    }

    private function colorFor(
        hue: Float,
        saturation: Float = 0.8,
        lightness: Float = 0.5
    ) : Int {
        final vec = new h3d.Vector();
        vec.makeColor(hue, saturation, lightness);
        return vec.toColor();
    }

    static function main() {
        new Main();
    }
}
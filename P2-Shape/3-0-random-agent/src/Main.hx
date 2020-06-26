import hxd.Key;
import h2d.Scene.ScaleMode;
import h2d.Scene.ScaleModeAlign;

class Agent {
    private var x: Float;
    private var y: Float;

    static var directions : Array<{x: Float, y: Float}> = [
        { x: -1.0, y: 0.0 }, // left
        { x: 1.0, y: 0.0 },  // right
        { x: 0.0, y: -1.0 }, // down
        { x: 0.0, y: 1.0 } // up
    ];

    public function new(x: Float, y: Float) {
        this.x = x;
        this.y = y;
    }

    public function step(size: Float, bounds: {max_x: Float, max_y: Float}) {
        final direction_index = Math.floor(Math.random() * directions.length);
        x += directions[direction_index].x * size;
        y += directions[direction_index].y * size;

        if (x < 0) { x = 0; }
        else if (x > bounds.max_x) { x = bounds.max_x; }

        if (y < 0) { y = 0; }
        else if (y > bounds.max_y) { y = bounds.max_y; }
    }

    public function render(graphics: h2d.Graphics) {
        graphics.drawCircle(x, y, 1, 6);
    }
}

class Main extends hxd.App {

    var graphics : h2d.Graphics;

    /* The size, in pixels, for each grid cell. */
    var gridSize : Int = 40;

    var agents : Array<Agent> = [];

    override function init() {
        graphics = new h2d.Graphics(s2d);
        hxd.Window.getInstance().addEventTarget(onEvent);
        resetAgents();
    }

    function onEvent(event: hxd.Event) {
        switch (event.kind) {
            case ERelease:
                resetAgents();
            case EKeyUp:
                if (event.keyCode == Key.SPACE) {
                    graphics.clear();
                }
            default: // do nothing
        }
    }

    override function onResize() {
        resetAgents();
        graphics.clear();
    }

    override function update(dt: Float) {
        graphics.beginFill(colorFor(Math.PI), 0.4);
        for (agent in agents) {
            agent.step(2, {max_x: s2d.width, max_y: s2d.height});
            agent.render(graphics);
        }
        graphics.endFill();
    }

    function resetAgents() {
        final rows = Math.ceil(s2d.height / gridSize);
        final cols = Math.ceil(s2d.width / gridSize);

        agents = [
            for (x_ind in 0...cols) {
                for (y_ind in 0...rows) {
                    new Agent(x_ind * gridSize, y_ind * gridSize);
                }
            }
        ];
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
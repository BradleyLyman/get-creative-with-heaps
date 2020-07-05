import hxd.Window.DisplayMode;
import h2d.Interactive;
import hxd.Key;
import h2d.Scene.ScaleMode;
import h2d.Scene.ScaleModeAlign;

class Agent {
    private var x: Float;
    private var y: Float;

    static var directions : Array<{x: Float, y: Float}> = [
        { x: 0.0, y: -1.0 }, // down
        { x: 0.0, y: 1.0 }, // up

        { x: -1.0, y: 0.0 }, // left
        { x: -0.5, y: 0.5 }, // up to the left
        { x: -0.5, y: -0.5}, // down to the left

        { x: 1.0, y: 0.0 },  // right
        { x: 0.5, y: 0.5 }, // up to the left
        { x: 0.5, y: -0.5}, // down to the left
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
        graphics.drawCircle(x, y, 4, 6);
    }
}

class Main extends hxd.App {

    var graphics : Array<h2d.Graphics>;
    var current : Int = 0;

    /* The size, in pixels, for each grid cell. */
    var gridSize : Int = 100;

    var agents : Array<Agent> = [];

    override function init() {
        graphics = [for (i in 0...300) new h2d.Graphics(s2d)];
        new support.h2d.FullscreenButton(s2d);
        hxd.Window.getInstance().addEventTarget(onEvent);
        resetAgents();
    }

    function onEvent(event: hxd.Event) {
        switch (event.kind) {
            case ERelease:
                for (grahpic in graphics) { grahpic.clear(); }
            case EKeyUp:
                if (event.keyCode == Key.SPACE) {
                    resetAgents();
                }
            default: // do nothing
        }
    }

    override function onResize() {
        resetAgents();
        for (grahpic in graphics) { grahpic.clear(); }
    }

    override function update(dt: Float) {
        graphics[current].clear();
        graphics[current].beginFill(colorFor(lerp(current/graphics.length, Math.PI/2, 3*Math.PI/2)), 0.2);
        for (agent in agents) {
            agent.step(7, {max_x: s2d.width, max_y: s2d.height});
            agent.render(graphics[current]);
        }
        graphics[current].endFill();

        current += 1;
        if (current >= graphics.length) { current = 0; }
    }

    function resetAgents() {
        final h = s2d.height;
        final w = s2d.width;
        final rows = Math.ceil(h / gridSize);
        final cols = Math.ceil(w / gridSize);

        agents = [
            for (x_ind in 0...cols) {
                for (y_ind in 0...rows) {
                    new Agent(((s2d.width - w)/2) + (x_ind * gridSize), ((s2d.height - h)/2) + (y_ind * gridSize));
                }
            }
        ];
    }

    private function lerp(x: Float, start: Float, end: Float) : Float {
        return x*(end - start) + start;
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
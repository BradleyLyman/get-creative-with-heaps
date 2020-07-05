package drawable;

import h3d.mat.Texture;

class FastLines extends h2d.Drawable {
  final quads : QuadsPrimitive;
  final white : Texture;

  public function new(parent: h2d.Object) {
    super(parent);
    this.quads = new QuadsPrimitive();
    this.white = Texture.fromColor(0xFFFFFF, 1.0);
  }

  public function addLine(line: Line, width: Float) {
    quads.push(line.toQuad(width));
  }

  public function clear() {
    quads.reset();
  }

  override function draw(ctx: h2d.RenderContext) {
    if (!ctx.beginDrawObject(this, white)) { return; }
    quads.render(ctx.engine);
  }
}

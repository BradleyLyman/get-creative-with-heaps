import h2d.Graphics;
import hxsl.ShaderList;
import h3d.mat.MaterialSetup;
import h3d.scene.Mesh;
import h3d.prim.Cube;
import h3d.mat.Texture;

class MyTriangle extends h3d.prim.Primitive {
	public function new() {}

	override function triCount() {
		return 1;
	}

	override function vertexCount() {
		return 3;
	}

	override function alloc( engine : h3d.Engine ) {
		var v = new hxd.FloatBuffer();
		v.push( 100 );  // xy
    v.push( 100 );

    v.push( 0 ); // uv
    v.push( 0 );

    v.push( 1.0 ); // rgba
    v.push( 1.0 );
    v.push( 1.0 );
    v.push( 1.0 );

    v.push( 200 );  // xy
    v.push( 200 );

    v.push( 0 ); // uv
    v.push( 0 );

    v.push( 1.0 ); // rgba
    v.push( 1.0 );
    v.push( 1.0 );
    v.push( 1.0 );

    v.push( 100 );  // xy
    v.push( 200 );

    v.push( 0 ); // uv
    v.push( 0 );

    v.push( 1.0 ); // rgba
    v.push( 1.0 );
    v.push( 1.0 );
    v.push( 1.0 );

		buffer = h3d.Buffer.ofFloats(v, 8, [Triangles, RawFormat]);
	}

	override function render(engine:h3d.Engine) {
		if( buffer == null || buffer.isDisposed() ) alloc(engine);
		engine.renderTriBuffer(buffer);
	}
}

class MyDrawableThingy extends h2d.Drawable {
  final first : First;
  final col : Texture;

  public function new(parent: h2d.Object) {
    super(parent);
    this.first = new First();
    this.col = Texture.fromColor(0xFFFFFF, 1.0);
  }

  override function draw(ctx: h2d.RenderContext) {
    if (!ctx.beginDrawObject(this, col))  {
      trace("coludn't start!");
      return;
    }
    first.render(ctx.engine);
  }
}

class Main extends hxd.App {

  var frames = new RollingAverage();

  override function init() {
    new FullscreenButton(s2d);
    new MyDrawableThingy(s2d);
  }

  private function timedUpdate(dt) {
  }

  static function main() {
    new Main();
  }
}

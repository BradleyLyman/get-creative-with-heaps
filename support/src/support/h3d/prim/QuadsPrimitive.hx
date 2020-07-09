package support.h3d.prim;

import support.linAlg2d.Quad;
import support.linAlg2d.Vec;

/**
    Objects of this type represent a collection of quads which can all be
    rendered with the exact same texture/material.

    The assumption with this primitive is that *typically* push() will be called
    a bunch of times in a row to generate a ton of geometry.
**/
class QuadsPrimitive extends h3d.prim.Primitive {
  var vertices: hxd.FloatBuffer;
  var dirty: Bool;

	/* Create a new instance of the primitive. */
	public function new() {
    this.vertices = new hxd.FloatBuffer();
    this.dirty = true;
  }

  /**
      Add a quad to the primitive.

      Each vertex is pushed into internal buffers in the correct order and
      layout. The GPU buffer is marked for an update on the next frame.
      @param quad the Quad object to actually render
  **/
  public function push(quad: Quad) {
    pushVertex(quad.bottomLeft, 0, 0);
    pushVertex(quad.topLeft, 0, 1);
    pushVertex(quad.bottomRight, 1, 0);
    pushVertex(quad.topRight, 1, 1);
  }

  /**
      Resize the vertex buffer and dispose the GPU buffer.
  **/
  public function reset() {
    vertices = new hxd.FloatBuffer();
    disposeGPUBuffer();
  }

  /**
      Allocate the GPU buffer and stuff it full of our vertices.
  **/
  override function alloc(engine: h3d.Engine) {
    disposeGPUBuffer();
    buffer = h3d.Buffer.ofFloats(vertices, 8, [Quads, RawFormat]);
  }

	/**
      Render all quads in a single draw call.

      Assumes that the engine has been properly configured via some render
      context.
	**/
	override function render(engine: h3d.Engine) {
		if( buffer == null || buffer.isDisposed() || dirty == true ) alloc(engine);
		engine.renderQuadBuffer(buffer);
  }

  /**
      Dispose the internal buffer.

      It'll be reallocated on the next render. It's debatable if this is faster
      or slower than attempting to reuse the GPU buffer. It probably depends
      on the target platform and the engine implementation.
  **/
  private function disposeGPUBuffer() {
    if (buffer != null && !buffer.isDisposed()) {
      buffer.dispose();
      buffer = null;
    }
  }

  /**
      Add a new vertex to the internal buffer.
      Marks the vertices as dirty so the next render call will update the
      h3d.Buffer with the new data.
  **/
  private function pushVertex(p: Vec, u: Float, v: Float) {
    dirty = true;

		vertices.push( p.x );  // xy
    vertices.push( p.y );

    vertices.push( u ); // uv
    vertices.push( v );

    vertices.push( 1.0 ); // rgba
    vertices.push( 1.0 );
    vertices.push( 1.0 );
    vertices.push( 1.0 );
  }
}

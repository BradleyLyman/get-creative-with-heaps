# First Triangle

## Run the Demo

```
> haxe ./build.hxml
```

# Overview

This was my first pass at digging through the Heaps.io implementation to work
out how the various pieces fit together. The goal: render the proverbial first
triangle in 2D.

This is the list of types and things I learned about them in no particular
order:

## Engine

aka the
```haxe
h3d.impl.Engine
```

This is the core abstraction over the low-level graphics engine. There are
different implementations for Flash, OpenGL (via SDL), and DirectX.

The implementation is highly targeted to the *current* needs of the Heaps.io
engine. For example, there are methods for rendering geometry but no official
support for rendering LINES or POINTS. Presumably because games pretty much
always *only* use rich graphics which are textured.

## RenderContext

There are two of these in the library the
```haxe
h3d.RenderContext
```
and the
```haxe
h2d.RenderContext
```

In general, these seem to be a state machine of runtime details which the
engine requires when turning geometry into pixels. This means the RenderContext
includes the compiled shader and the bindings from cpu data. It looks like the
RenderContext is in charge of setting up shader uniforms like transform
matricies.

## Primitive

The core primitive type is
```haxe
h3d.prim.Primitive
```

It's a bit weirdly named because the needs for a primitive in 2d and 3d are
so different. *But* each primitive is responsible for telling the engine how to
allocate it's buffers and how to render them.
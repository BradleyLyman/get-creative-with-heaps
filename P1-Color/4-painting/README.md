# Painting

## Run the Demo

```
> haxe ./build.hxml
```

## Usage

Move the mouse anywhere on screen to leave a trail of dots. The mouse's X
position controls the radius of the dot.

Color changes with time.

# Technical Notes

This demo shows how to capture an object graph into a single fullscreen
texture. It accomplishes the same effect as just not clearing the screen, but
having a texture means future demos can implement behaviour which depends on
the screen contents.

## Render to Texture

There are different ways of rendering to a texture. Looking at the official
documentation the standard approach would be

```haxe
var texture = new Texture(width, height, [Target], RGBA);
var engine = h3d.Engine.getCurrent();
engine.pushTarget(texture);
s2d.render(engine);
engine.popTarget();
```

This was causing all sorts of trouble with scaling. I believe this is because
I don't properly understand how the scene interacts with the engine.

But, Heaps provides an alternative approach which this demo uses:

```haxe
var texture = new Texture(width, height, [Target], RGBA);
s2d.drawTo(texture);
```

Which entirely solves the afformentioned problem.

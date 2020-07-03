# Intelligent Agents

# Run The Demo

```
> haxe ./build.hxml
```

# Usage

Move the mouse to guide the circle around the screen.

# Implementation Notes

The circle on the screen is controlled by a single agent. The agent maintains a
ring of vertices which initially form a circle around
the center point. The center point will move to follow the mouse while the
points in the circle jitter randomly.

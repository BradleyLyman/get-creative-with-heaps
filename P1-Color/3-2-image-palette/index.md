---
layout: demo
section: P1 Color
order: 3.2
title: Image Palette
---

# Usage

* Click the mouse anywhere on the screen to cycle to the next image
* Press a number key to select the pixel order:
  * `1` orders pixels by hue
  * `2` orders pixels by saturation
  * `3` orders pixels by value (lightness)
  * any other key resets the pixels to their original order

# Overview

Every picture has a secret color palette. One way to tease it out is to reorganize the picture
according to the color properties of it's parts. This deconstruction can help the eye to
see the *color* pattern instead of the shape of the picture itself.

## Implementation Notes

Some notes from the implementation.

### Sorting Pixels

Sorting pixels is a super weird operation. It's certainly not a *common* need for a game engine.

This demo provides a way to sort pixels in the `PixelTools.hx`. This demonstrates a fun feature of
the haxe programming language: [static extensions](https://haxe.org/manual/lf-static-extension.html).
In the `Main.hx` demo source, look for a place where `toSorted` is called on an instance of `hxd.Pixels`!

### Reading Images

Heaps.io provides *amazing* support for reading resources out of the `res` directory. They can be accessed
with the `hxd.Res.` prefix, look for it in the code!




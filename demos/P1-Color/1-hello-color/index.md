---
layout: demo
title: "P1.1 Hello Color"
---

# Usage

* The mouse's Y position controls the hue of the background and the foreground rectangle.
* The mouse's X position controls the size of the foreground rectangle.

# Overview

Color is foundational to any design, generative or not, and is therefore where this series begins!

## Some Background

The relationship between light, the human eye, and reflective surfaces means that color *in general* is
a surprisingly complicated subject. Work with computers long enough and you've almost certainly encountered
the RGB or "Red, Green, Blue" description for color. RGB is hardly the only way to represent colors. There
is an alternative system which uses values for hue (H), saturation (S), and lightness (L) to represent color.

The HSL color representation falls into the general category of cyndrilical color models and there is some
excellent information available on the [HSL and HSV Wikipedia Article](https://en.wikipedia.org/wiki/HSL_and_HSV).

## Implementation Notes

A few notes about the implementation of this and future demos.

### 2D Graphics

Rendering arbitrary 2d graphics can be done using the [`h2d.Graphics`](https://heaps.io/api/h2d/Graphics.html) class,
which just be called `Graphics` from now on. Selecting a color for the rendered graphic is done by calling
`graphics.beginFill` which accepts a 32-bit integer containing information for an RGBA color.

### HSL Batteries Included

Heaps.io includes a technique which can be used to change from the HSL representation to the 32-bit
RGBA color:

```haxe
var vec = new h3d.Vector();            // this type represents a mathematical Vector in 3 dimensions
vec.makeColor(hue, saturation, color); // this calculates the RGB representation for the HSL values
vec.toColor();                         // This method creates 32-bit int used by Graphics
```

## Additional Reading

There are other models which instead emphasize human perception by introducing even more values.
An example is the [CIELAB Color Space](https://en.wikipedia.org/wiki/CIELAB_color_space). It could
be very interesting to explore this color space for other demos.


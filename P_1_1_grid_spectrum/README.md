# Grid Spectrum

How does one get an intuition for color? By looking at all of them, of course!
This demo shows the HSL color gamut by dividing the screen into a grid of
colored squares.

## How To Run

The program automatically starts when built.

```
> haxe ./build.hxml
```

![Demo Screenshot](https://github.com/BradLyman/learn_you_a_heaps/blob/master/p_1_1_grid_spectrum/Screenshot.png)

## What Is Happening?

The screen is divided into a grid of rectangles. The x coordinate of the left
of each rectangle is scaled from [0, 2*PI] to represent the hue for that
rectangle. The Y coordinate of the top of the rectangle is scaled from [0 1] to
show the lightness for that rectangle.

Rectangle sizes are controlled by the mouse position. The X coordinate controls
the horizontal divisions and the Y coordinate controls the vertical divisions.
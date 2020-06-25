# Grid Spectrum

![Low Resolution Grid](https://github.com/BradLyman/learn_you_a_heaps/blob/master/P1-Color/2-grid-spectrum/Screenshot1.png)

![High Resolution Grid](https://github.com/BradLyman/learn_you_a_heaps/blob/master/P1-Color/2-grid-spectrum/Screenshot2.png)

## Run The Demo

```
> haxe ./build.hxml
```

**Usage**

* The mouse's Y coordinate controls the number of colors top to bottom
* The mouse's X coordinate controls the number of colors left to right

# Overview

Build an intuition for HSB Colors by dividing the entire screen into a color grid.

## Implementation Notes

The screen is divided into a grid of rectangles. The x coordinate of the left
of each rectangle is scaled from [0, 2π] to represent the hue for that
rectangle. The Y coordinate of the top of the rectangle is scaled from [0, 1] to control 
the brightness for that rectangle.

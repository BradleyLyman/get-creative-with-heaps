---
title: "Grid Spectrum"
order: 2
section: "P1 Color"
layout: demo
---

# Usage

* The mouse's Y coordinate controls the number of colors top to bottom
* The mouse's X coordinate controls the number of colors left to right

# Overview

Build an intuition for HSB Colors by dividing the entire screen into a color grid.

## Implementation Notes

The screen is divided into a grid of rectangles. The x coordinate of the left
of each rectangle is scaled from [0, 2π] to represent the hue for that
rectangle. The Y coordinate of the top of the rectangle is scaled from [0, 1] to control
the brightness for that rectangle.

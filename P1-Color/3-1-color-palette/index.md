---
layout: demo
title: P1.3.1 Color Palette
---

# Usage

* Click the mouse anywhere on screen to change the colors used for interpolation
* The mouse's X coordinate controls the number of divisions left to right

# Overview

One of the main strengths of the HSB color model is that colors look good when interpolated!
This demo picks 10 random colors on the HSB color wheel and interpolates between them to
create palettes of colors.

## Implementation Notes

This demo uses window events to trigger rebuilding geometry, rather than rebuilding on every frame.

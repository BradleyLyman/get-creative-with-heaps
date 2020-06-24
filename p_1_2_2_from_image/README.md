# Palette From Image

This demo shows how every image has a hidden color palette. By reorganizing the pixels in a image
that palette can be teased out. 

## How To Run

The program automatically starts when built.

```
> haxe ./build.hxml
```

**Raw Image**
![Demo Screenshot](https://github.com/BradLyman/learn_you_a_heaps/blob/master/p_1_2_2_from_image/NoFilter.png)

**Pixels Ordered By Hue**
![Demo Screenshot](https://github.com/BradLyman/learn_you_a_heaps/blob/master/p_1_2_2_from_image/OrderByHue.png)

**Pixels Ordered By Saturation**
![Demo Screenshot](https://github.com/BradLyman/learn_you_a_heaps/blob/master/p_1_2_2_from_image/OrderBySaturation.png)

**Pixels Ordered By Value**
![Demo Screenshot](https://github.com/BradLyman/learn_you_a_heaps/blob/master/p_1_2_2_from_image/OrderByValue.png)

## Controls

Click the mouse anywhere on the screen to cycle to the next image.

Press a number key to select the pixel order:
  * `1` orders pixels by hue
  * `2` orders pixels by saturation
  * `3` orders pixels by value (lightness)
  * any other key resets the pixels to their original order

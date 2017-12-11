#!/bin/sh
xrandr --output HDMI1 --auto --primary --mode 3440x1440 --panning 6020x2520 \
  --scale 1.75x1.75 --pos 0x0 --rotate normal --output VIRTUAL1 --off \
  --output DP1 --off --output eDP1 --off --output DP2 --off

feh ~/Pictures/classic-wheels-3440x1440.jpg --bg-scale

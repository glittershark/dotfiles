#!/bin/bash
export DISPLAY=":0.0"
export XAUTHORITY="/home/smith/.Xauthority"

if [[ $(< /sys/class/drm/card1-DP-2/status) = "connected" ]]; then
  xrandr --output LVDS-2 --mode 1440x900 --pos 0x0 --rotate normal \
    --output DP-2 --mode 1440x900 --pos 1440x0 --rotate normal
else
  xrandr --auto
fi

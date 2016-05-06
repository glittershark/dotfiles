#!/bin/bash
eval $(slop)
[[ $Cancel == "true" ]] || ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -f pulse -i default ~/screenrecord.gif

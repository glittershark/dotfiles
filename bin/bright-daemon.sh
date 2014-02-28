#!/bin/zsh

if [ -e /sys/class/backlight/nv_backlight ]; then
  BACKLIGHT="/sys/class/backlight/nv_backlight"
elif [ -e /sys/class/backlight/gmux_backlight ]; then
  BACKLIGHT="/sys/class/backlight/nv_backlight"
fi

function bright-adjust() {

  PERCENT_STEP=$[$(cat $BACKLIGHT/max_brightness) / 100]
  CUR_LEVEL=$(cat $BACKLIGHT/brightness)

  if [ $1 = "--current" ]; then
    CUR_PERCENT=$(expr $CUR_LEVEL / $PERCENT_STEP)
    echo "${CUR_PERCENT}%" 
    return
  fi

  if NEW_LEVEL=$[$CUR_LEVEL + $[$1 * $PERCENT_STEP]]; then
    if echo $NEW_LEVEL > $BACKLIGHT/brightness > /dev/null; then
      NEW_PERCENT=$(expr $NEW_LEVEL / $PERCENT_STEP)
      echo "${NEW_PERCENT}%"
    fi
  fi
}


while true; do
  delta=$(< /home/smith/bin/bright.fifo)
  echo $delta # TEST
  bright-adjust $delta
done

# vim: set filetype=zsh


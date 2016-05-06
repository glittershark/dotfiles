#!/bin/bash

function get_small() {
  local num_desktops
  local current_desktop

  num_desktops="$(xdotool get_num_desktops)"

  # 1 or 2 desktops; everything is big
  if [ "$num_desktops" -lt 2 ]; then
    return
  fi

  current_desktop="$(xdotool getactivewindow get_desktop_for_window)"

  if [ "$current_desktop" = 1 ] || [ "$current_desktop" = 2 ]; then
    echo "-small"
    return
  fi
}

if [ "$(< ~/.term_dark)" = 't' ]; then
  exec "/usr/local/bin/st-dark$(get_small)" $@
else
  exec "/usr/local/bin/st-light$(get_small)" $@
fi


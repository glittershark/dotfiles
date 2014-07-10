#!/bin/bash

FILE="/home/smith/.term_dark"

if [ "$(< $FILE)" = 't' ]; then
  echo 'f' > $FILE
else
  echo 't' > $FILE
fi


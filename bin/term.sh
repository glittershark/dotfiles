#!/bin/bash

if [ "$(< ~/.term_dark)" = 't' ]; then
  exec /usr/local/bin/st-dark $@
else
  exec /usr/local/bin/st-light $@
fi


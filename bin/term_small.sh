
#!/bin/bash

if [ "$(< ~/.term_dark)" = 't' ]; then
  exec /usr/local/bin/st-dark-small $@
else
  exec /usr/local/bin/st-light-small $@
fi


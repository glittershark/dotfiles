#!/bin/sh
(
  cd /home/smith/downloads

  FILE_LIST="/tmp/files.txt"

  /bin/ls | /bin/grep -v \^bak\$ > $FILE_LIST
  tar -cvzf bak/$(date "+%Y%m%d").tar.gz -T $FILE_LIST

  rm -rf $(< $FILE_LIST)
)

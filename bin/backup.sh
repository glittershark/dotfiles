#!/bin/bash
for dir in $(< /home/griffin/.tarsnap/backup_dirs) ; do
    nice -n 10 tarsnap -c -f $(hostname)-$(date -u +%Y%m%d-%H%M%S)-$(echo $dir | tr '/' '-') -C / $dir
done

# Delete backups more than n days old
# n=10
# tarsnap --list-archives | sort | cut -d- -f1-2 | uniq | tail -n +$n &gt; /tmp/temp.$$
# tarsnap --list-archives | fgrep -f /tmp/temp.$$ | while read archive ; do
#     echo Deleting $archive
#     tarsnap -d -f $archive
# done
# rm /tmp/temp.$$

tarsnap --print-stats

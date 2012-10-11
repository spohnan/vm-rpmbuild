#!/bin/sh
#
# update_repos.sh - Mirror someone else's repo using rsync
#

rsync="/usr/bin/rsync -aqHz --delete"
mirror=rsync://rsync.gtlib.gatech.edu/centos

verlist="5 6"
archlist="x86_64"
baselist="os updates"
local=/var/www/html/repo/CentOS

for ver in $verlist
do
    for arch in $archlist
    do
        for base in $baselist
        do
            remote=$mirror/$ver/$base/$arch/
            $rsync $remote $local/$ver/$base/$arch/
        done
    done
done

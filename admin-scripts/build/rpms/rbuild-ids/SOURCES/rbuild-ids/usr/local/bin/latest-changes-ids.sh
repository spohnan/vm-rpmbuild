#!/bin/bash
#
# latest-changes-ids.sh - locate and cat the latest log report from the ids system
#

source /etc/vm-rpmbuild/ids/aide-settings.sh


ls -t $LOGDIR/aide.*.log | head -1 | xargs -d '\n' cat
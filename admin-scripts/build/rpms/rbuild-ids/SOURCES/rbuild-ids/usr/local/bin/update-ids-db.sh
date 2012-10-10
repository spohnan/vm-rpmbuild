#!/bin/bash
#
# update-ids-db.sh - Silence the ids alarm by updating the db
#

source /etc/vm-rpmbuild/ids/aide-settings.sh

# If there's no db then skip as there's nothing to update
if test -f $DB_FILE ; then

    /bin/nice -19 /usr/sbin/aide --config=$CONFIG_FILE --update

    reset_db

    update_logs

fi

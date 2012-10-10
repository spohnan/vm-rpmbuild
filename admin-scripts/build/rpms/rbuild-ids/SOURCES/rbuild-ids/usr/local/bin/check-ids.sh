#!/bin/bash
#
# check-ids.sh - Run the intrusion detection system and update status file
#

source /etc/vm-rpmbuild/ids/aide-settings.sh

# If the db file is already there run a check against it
if test -f $DB_FILE ; then

    # It's a bit resource intensive so we're setting a pretty low priority
    /bin/nice -19 /usr/sbin/aide --config=$CONFIG_FILE --check

    # Examine the return value and update to the appropriate status
    RETVAL=$(echo $?)
    if test $RETVAL -eq 0 ; then
        set_status_ok
    else
        set_status_changed
    fi
else

    # If not db is present this is the first running so we need to init a db
    /bin/nice -19 /usr/sbin/aide --config=$CONFIG_FILE --init

    # Move the new db into place and init status to OK
    reset_db
fi

update_logs
update_login_console

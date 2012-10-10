#!/bin/bash
#
# run-ids.sh - Run the intrusion detection system and update status file
#

source /etc/vm-rpmbuild/ids/aide-settings.sh

# If the db file is already there run a check against it
if test -f $DB_FILE ; then

    /usr/sbin/aide --config=$CONFIG_FILE --check

    # Examine the return value and update to the appropriate status
    RETVAL=$(echo $?)
    if test $RETVAL -eq 0 ; then
        echo $STATUS_OK > $STATUS_FILE
    else
        echo $STATUS_CHANGED > $STATUS_FILE
    fi
else

    # If not db is present this is the first running so we need to init a db
    /usr/sbin/aide --config=$CONFIG_FILE --init

    # Move the new db into place and init status to OK
    mv $NEW_DB_FILE $DB_FILE
    echo $STATUS_OK > $STATUS_FILE
fi

# Give the log file a date stamp so they don't overwrite each other
mv $LOGDIR/$LOG_FILE_NAME $LOGDIR/aide.$(date +%Y%m%d%H%M%S).log

# List logs sorted by most recent first, chop off the oldest using tail and pipe to rm
ls -t $LOGDIR | tail -n +$(($MAX_NUM_LOGS+1)) | xargs -d '\n' rm -f

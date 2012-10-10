#!/bin/bash

CONFIG_FILE=/etc/vm-rpmbuild/ids/aide.conf
STATUS_FILE=/etc/vm-rpmbuild/ids/status
STATUS_OK="OK"
STATUS_CHANGED="CHANGED"
IDS_HOME=/mnt/vm-rpmbuild/ids
DBDIR=$IDS_HOME
DB_FILE=$DBDIR/aide.db.gz
NEW_DB_FILE=$DBDIR/aide.db.new.gz
LOGDIR=$IDS_HOME/logs
LOG_FILE_NAME=aide.log
MAX_NUM_LOGS=10


update_logs() {
    # Give the log file a date stamp so they don't overwrite each other
    mv $LOGDIR/$LOG_FILE_NAME $LOGDIR/aide.$(date +%Y%m%d%H%M%S).log

    # List logs sorted by most recent first, chop off the oldest using tail and pipe to rm
    ls -t $LOGDIR | tail -n +$MAX_NUM_LOGS | xargs -d '\n' rm -f
}

reset_db() {
    if test -f $NEW_DB_FILE ; then
        mv -f $NEW_DB_FILE $DB_FILE
        echo $STATUS_OK > $STATUS_FILE
    fi
}

update_login_console() {
    # Should be there but check to ensure we
    if test -f /etc/init.d/login-console ; then
        /sbin/service login-console restart
    fi
}

set_status_ok() {
    echo $STATUS_OK > $STATUS_FILE
}

set_status_changed() {
    echo $STATUS_CHANGED > $STATUS_FILE
}
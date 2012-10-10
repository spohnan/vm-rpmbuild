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
MAX_NUM_LOGS=10
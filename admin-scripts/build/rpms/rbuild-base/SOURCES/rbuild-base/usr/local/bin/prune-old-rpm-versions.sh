#!/bin/bash
#
# prune-old-rpm-versions.sh - Delete oldest versions of rpms from repo
#
# This script is meant to keep dev repos from growing to monstrous sizes
# In the Jenkins job this can be called to keep around only a set number
# of RPMs
#

# Sanity checks to ensure we got the rpm-repo-dir arg
if test $# -ne 3 ; then
    echo "Usage: `basename $0` rpm-repo-dir rpm-name num-copies-to-keep"
    exit -1
fi

RPM_REPO_DIR="$1"
RPM_NAME="$2"
COPIES_TO_KEEP=$3

# List rpms sorted by most recent first, chop off the oldest using tail and pipe to rm
ls -t $RPM_REPO_DIR/SRPMS/$RPM_NAME* | tail -n +$(($COPIES_TO_KEEP+1)) | xargs -d '\n' rm -f
ls -t $RPM_REPO_DIR/x86_64/$RPM_NAME* | tail -n +$(($COPIES_TO_KEEP+1)) | xargs -d '\n' rm -f

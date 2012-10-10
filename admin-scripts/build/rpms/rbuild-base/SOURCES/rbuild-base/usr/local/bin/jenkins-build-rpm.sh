#!/bin/bash
#
# jenkins-build-rpm.sh - Top level script that runs all the commands needed to build an rpm task in Jenkins
#
# If all the conventions have been followed this script can be used to keep the Execute shell command window short
#   - Jenkins job has the same name as the RPM
#   - RPM spec file has the same name as the RPM
#
# With these two naming conventions we can now use the Jenkins $JOB_NAME environment var and not have to update
# scripts for each new job. Being able to just copy one task and change the name makes it much easier to set up quickly
#

# Sanity checks to ensure we got the rpm-repo-dir arg
if test $# -ne 1 ; then
    echo "Usage: `basename $0` rpm-repo-dir"
    exit -1
fi

if ! test -d "$1" ; then
    echo "'$1' is not a directory"
    exit -1
fi

RPM_REPO_DIR="$1"
SCRIPT_HOME="/usr/local/bin"
MAX_NUM_RPMS_IN_REPO=5

# Build the rpms
$SCRIPT_HOME/build-rpms.sh $JOB_NAME $JOB_NAME.spec

# Keep the number of RPMs from blowing up by pruning. Copying a new version next so number
# should be one less than the total you want to keep
$SCRIPT_HOME/prune-old-rpm-versions.sh $RPM_REPO_DIR $JOB_NAME $(($MAX_NUM_RPMS_IN_REPO -1))

# Copy RPMs and update local repo
$SCRIPT_HOME/jenkins-update-rpm-repo.sh $RPM_REPO_DIR
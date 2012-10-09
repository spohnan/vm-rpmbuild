#!/bin/bash
#
# build-rpms.sh - Create both source and binary rpms
#

if test $# -ne 2 ; then
    echo "Usage: `basename $0` rpm-name spec-file-name"
    exit -1
fi

RPM_NAME="$1"
SPEC_FILE_NAME="$2"

rpmbuild \
    --define "_topdir /mnt/vm-rpmbuild/jenkins/jobs/$RPM_NAME/workspace" \
    --define "release `date +%Y%m%d%H%M%S`" \
    -ba SPECS/$SPEC_FILE_NAME

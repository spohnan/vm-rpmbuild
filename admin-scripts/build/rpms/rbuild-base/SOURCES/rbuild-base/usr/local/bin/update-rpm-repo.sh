#!/bin/bash
#
# update-rpm-repo.sh - Create a new rpmbuild vm appliance
#
# This script is meant to be used by the Jenkins build service to copy
# RPMs from the local build workspace to a hosted RPM repo and make it
# available by setting the right permissions and updating the repodata
#

# Sanity checks to ensure we got the rpm-repo-dir arg
if test $# -ne 1 ; then
    echo "Usage: `basename $0` rpm-repo-dir"
    exit -1
fi

if test -d "$1" ; then
    echo "'$1' is not a directory"
    exit -1
fi

RPM_REPO_DIR="$1"

# Copy to the dev repo
cp RPMS/noarch/*.rpm $RPM_REPO_DIR/x86_64
cp SRPMS/*.rpm $RPM_REPO_DIR/SRPMS

# Make SELinux happy
chcon unconfined_u:object_r:httpd_sys_content_t:s0 $RPM_REPO_DIR/x86_64/*.rpm
chcon unconfined_u:object_r:httpd_sys_content_t:s0 $RPM_REPO_DIR/SRPMS/*.rpm

# Update repo metadata
createrepo -d $RPM_REPO_DIR/x86_64
createrepo -d $RPM_REPO_DIR/SRPMS

#!/bin/bash
#
# repo-patch.sh - Create a repo that consists of the union of the latest packages from
#                 an OS repo and as many other repos as desired. The result of this operation
#                 will be a repo we can use as an install tree from a kickstart that will be
#                 constantly updated with all the latest patches. The tool used for the merging
#                 is Novi - http://www.exmachinatech.net/01/novi/ which is a multi purpose
#                 rpm repo tool I just happen to be using it here to create a patched source repo
#

# All the repos live here
REPO_HOME_BASE=/var/www/html/repo

# This is the root of the CentOS 6 tree. Here lives two repos for os/ and updates/
ORIG_CENTOS_6_REPO=$REPO_HOME_BASE/CentOS/6

# The merged repo we will be creating
PATCHED_CENTOS_6_REPO_HOME=$REPO_HOME_BASE/CentOS-patched/6/os/x86_64

# Directory housekeeping
if ! test -d $PATCHED_CENTOS_6_REPO_HOME ; then
    mkdir -p $PATCHED_CENTOS_6_REPO_HOME
fi

# Not hard linking everything is a bit wasteful but the bootable images and such only take up ~200MB
# We're going to rebuild the repodata and Packages so they are being excluded from the copy
rsync -avz --exclude 'repodata' --exclude 'Packages' $ORIG_CENTOS_6_REPO/os/x86_64/ $PATCHED_CENTOS_6_REPO_HOME

# Now that we've synched all the static content we're going to recreate the repo structure with
# all the latest copies of packages. First set up the directories we skipped when syncing
cd $PATCHED_CENTOS_6_REPO_HOME

rm -fr Packages repodata
mkdir Packages repodata

# Use our custom group file with some additional named groups
cp /var/www/html/misc/comps.xml repodata

# Use the novi tool - http://www.exmachinatech.net/01/novi/ to link in all the latest packages
novi -a hardlink \
    -t Packages \
    $ORIG_CENTOS_6_REPO/os/x86_64/Packages \
    $ORIG_CENTOS_6_REPO/updates/x86_64/Packages

# Recreate the repodata information, would need to update the comps file name here if we later fork
createrepo --groupfile repodata/comps.xml --database .

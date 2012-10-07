#!/bin/bash
#
# create-vm-rpmbuild.sh - Create a new rpmbuild vm appliance
#
# Rather than continually tweaking an existing VM and forgetting the steps that get you
# to what works I'm choosing to automate the VM building process and continually rebuild.
#
# This particular script requires a bit of setup before it will be useful. I'm using KVM
# to build a new vm with a the one-liner (virt-install) and the locally mirrored build and
# update repos mean there's no time waiting for packages to download. A new VM can be built
# in around 3 minutes on my laptop
#
# VM Build Setup
#   - Machine running CentOS 6 (or RHEL 6) with KVM kernel and utilities installed
#   - Apache web server hosting kickstart files and mirrored build and update repos

# Requires a vm-name argument
if test $# -ne 1 ; then
    echo "Usage: `basename $0` vm-name"
    exit -1
fi

# Basic VM Settings
NUM_CPUS=2
MEMORY=2048
DISK_SIZE_IN_GB=40
DISK_FORMAT="qcow2"
DISK_STORAGE_LOCATION="/mnt/storage/vm-images"

# KVM comes with a one pre-configured network named "default" I just chose to
# recreate a network with a bit more descriptive name on my machine
NETWORK_NAME="host_only"

# This is used by the VM only during building and as long as you're
# only building one VM at a time you just have to ensure this one
# IP is free. Concurrent builds would take more coordination and a
# range of available addresses
TEMP_IP="192.168.100.13"

# Locally mirrored install tree
#   - $BUILD_SERVER/repo/CentOS/6/os/x86_64/
# Locally mirrored update repo
#   - $BUILD_SERVER/repo/CentOS/6/updates/x86_64/
# NOTE: Both of these settings are also in the build/vm-rpmbuild.ks file so if you
#       change this setting here update that file as well or the VM will be looking
#       in the wrong place for updates
BUILD_SERVER="http://192.168.100.2"


# Kick off the build
virt-install          \
    --name  $1        \
    --vcpus $NUM_CPUS \
    --ram   $MEMORY   \
    --os-variant rhel6 \
    --disk path=$DISK_STORAGE_LOCATION/$1.$DISK_FORMAT,size=$DISK_SIZE_IN_GB,format=$DISK_FORMAT \
    --network network=$NETWORK_NAME \
    --graphics vnc \
    --location $BUILD_SERVER/repo/CentOS/6/os/x86_64/ \
    --extra-args "ks=$BUILD_SERVER/kickstart/vm-rpmbuild.ks ksdevice=eth0 ip=$TEMP_IP"

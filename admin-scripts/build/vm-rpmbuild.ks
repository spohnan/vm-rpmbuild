install
text
skipx
keyboard us
lang en_US
timezone  Etc/UTC
auth  --useshadow  --enablemd5
bootloader --location=mbr
firewall --enabled --port=22:tcp,80:tcp,8181:tcp
firstboot --disable
network --hostname vm-rpmbuild
network --device eth0 --bootproto dhcp
rootpw --iscrypted $1$xHUoQCg9$b5Ngf3/vhIjeGaBD84puX1
selinux --enforcing

reboot

# Disk Recipe
# Reset partitions
zerombr
clearpart --all --initlabel

# Partition into boot and everything else
part /boot --fstype=ext4 --size=200
part pv.2 --size=1 --grow
# Set up lvm
volgroup VolGroup --pesize=4096 pv.2
logvol / --fstype=ext4 --name=lv_root --vgname=VolGroup --grow --size=1024
logvol swap --name=lv_swap --vgname=VolGroup --size=2048
# This may need some adjusting, trying to get rid of "Finding: Audit is not separated from critical system partitions."
# Source is http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf ~ page 18
logvol /var/log --fstype=ext4 --name=lv_log --vgname=VolGroup --grow --percent=3 --maxsize=10240
logvol /var/log/audit --fstype=ext4 --name=lv_audit --vgname=VolGroup --grow --percent=3 --maxsize=10240

repo --name="ThirdParty" --baseurl=http://192.168.100.2/repo/thirdparty/x86_64/

%packages --nobase
# Basic packages needed to run system
@core

# Some nice to have improvements
git
vim-enhanced
screen
# Listen for VM software startup/shutdown commands
acpid

# Needed to both install Apache httpd and configure selinux so it can run on multiple ports
policycoreutils-python
httpd

# Tomcat Java app server
tomcat6
tomcat6-native

# Packages needed to build rpms
rpm-build


%post
(

# Needs to be running to hear virtsh shutdown commands
/sbin/chkconfig acpid on
/sbin/chkconfig httpd on

# Set up the config directory
mkdir /etc/vm-rpmbuild
echo "1.0" > /etc/vm-rpmbuild/release

# Update web server config
/usr/sbin/semanage port -a -t http_port_t -p tcp 8181
cp /etc/httpd/conf/httpd.conf /etc/vm-rpmbuild/httpd.conf
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.orig
ln -s /etc/vm-rpmbuild/httpd.conf /etc/httpd/conf/httpd.conf
echo "
Listen 8181
ServerName vm-rpmbuild
" >> /etc/vm-rpmbuild/httpd.conf

# Just don't like to wait ;)
sed -i 's/timeout=5/timeout=0/' /etc/grub.conf

# Add the public key to my laptop account as an authorized user of the system
mkdir /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+YXXQ+LuE2eQSCwrnqsuef6yYRWNGL30w2rRn7CyXsjJ9YA0bvTO6CT7JOOjS1T2m6JD0bhku2bDYYaSNt1elfY+0XlQY7O9R83YSbvxevND7CD1u08wq1+VHDTWPfHf+spokU+G0qwshjaE0ZSIcx86va2RAIa8mQbvFsk6TU0fIU2u6Tx3Lea8ABQfCEGR0u9CYauL1ORZDdh0wUuF3oqL1JUm6OuB6HsigE2glx0dFbSvRAhJygaTine0PXQ6yhnEjvRt5mzxK2e4Qsu+r5lQqQfLKZz+nW22SHNwex8tFdh5o31oO3kmFKip+rkA9X1dVUDpWkhSEExGbp3ft andy@Andrews-MacBook-Pro-2.local" >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# Add our local repos as preferred
echo "
[local-base]
name=CentOS-Local - Base
baseurl=http://192.168.100.2/repo/CentOS/6/os/x86_64/
gpgcheck=0
cost=1

[local-updates]
name=CentOS-Local - Updates
baseurl=http://192.168.100.2/repo/CentOS/6/updates/x86_64/
gpgcheck=0
cost=1

[local-thirdparty]
name=Local - Third Party Software Mirror
baseurl=http://192.168.100.2/repo/thirdparty/x86_64/
gpgcheck=0
cost=1
" > /etc/yum.repos.d/CentOS-Local.repo

) > /root/post_install.log

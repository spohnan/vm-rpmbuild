install
text
skipx
keyboard us
lang en_US
timezone  Etc/UTC
auth  --useshadow  --enablemd5
bootloader --location=mbr
#TODO: If we use proxy through httpd get rid of 8080
firewall --enabled --port=22:tcp,80:tcp,8181:tcp,8080:tcp
#firewall --enabled --port=22:tcp,80:tcp,8181:tcp
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
# Appliance change detection
aide

# Needed to both install Apache httpd and configure selinux so it can run on multiple ports
policycoreutils-python
httpd

# Tomcat Java app server
jdk
tomcat6

# Packages needed to build and host rpms and repos
rpm-build
rpmlint
createrepo

# Custom packages
rbuild-base
rbuild-login-console

%post
(

# Needs to be running to hear virtsh shutdown commands
/sbin/chkconfig acpid on
/sbin/chkconfig httpd on
/sbin/chkconfig tomcat6 on

# Turn off some services we don't need at the moment
/sbin/chkconfig cups off
/sbin/chkconfig postfix off

# ---------------------------------------------------------------
# Update Apache httpd web server config
# ---------------------------------------------------------------
# Set up the repo hosting area
mkdir /var/www/html/repos
chown root:tomcat /var/www/html/repos
chmod g+s /var/www/html/repos
mkdir -p /var/www/html/repos/vm-rpmbuild-dev/{SRPMS,x86_64}
chmod -R 775 /var/www/html/repos

# Set up the config directory
mkdir /etc/vm-rpmbuild/web

# Allow httpd to run on an alternate port and to act as a network proxy
/usr/sbin/semanage port -a -t http_port_t -p tcp 8181
/usr/sbin/setsebool httpd_can_network_connect true

# Copy the original config file to our vm-rpmbuild config area
cp /etc/httpd/conf/httpd.conf /etc/vm-rpmbuild/web/httpd.conf

# Move the original config file out of the way
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.orig

# Link our config file into the original file location
ln -s /etc/vm-rpmbuild/web/httpd.conf /etc/httpd/conf/httpd.conf

# In addition to port 80 the server will also listen on 8181 which
# isn't a restricted port if you've got to do port forwarding
echo "
Listen 8181
ServerName vm-rpmbuild
#ProxyPass        /build http://localhost:8080/build
#ProxyPassReverse /build http://localhost:8080/build
#ProxyRequests Off
#ProxyPreserveHost On
#<Proxy http://localhost:8080/build*>
#   Order deny,allow
#   Allow from all
#</Proxy>
" >> /etc/vm-rpmbuild/web/httpd.conf
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Update Apache Tomcat web server config
# ---------------------------------------------------------------
# Copy the original config files to our vm-rpmbuild config area
cp /usr/share/tomcat6/conf/tomcat6.conf /etc/vm-rpmbuild/web/tomcat6.conf
cp /usr/share/tomcat6/conf/server.xml /etc/vm-rpmbuild/web/server.xml

# Move the original config files out of the way
mv /usr/share/tomcat6/conf/tomcat6.conf /usr/share/tomcat6/conf/tomcat6.conf.orig
mv /usr/share/tomcat6/conf/server.xml /usr/share/tomcat6/conf/server.xml.orig

# Link our config files into the original file locations
ln -s /etc/vm-rpmbuild/web/tomcat6.conf /usr/share/tomcat6/conf/tomcat6.conf
ln -s /etc/vm-rpmbuild/web/server.xml /usr/share/tomcat6/conf/server.xml

# Create an area out of the web root for Jenkins to store information
mkdir /mnt/jenkins
chown tomcat.tomcat /mnt/jenkins

# Modify the http connector element in the tomcat server.xml file so it
# works with our proxy and won't complain about Tomcat URI Encoding
#sed -i 's/connectionTimeout="20000"/connectionTimeout="20000" URIEncoding="UTF-8" proxyPort="80" proxyName="localhost"/' /etc/vm-rpmbuild/web/server.xml
sed -i 's/connectionTimeout="20000"/connectionTimeout="20000" URIEncoding="UTF-8"/' /etc/vm-rpmbuild/web/server.xml

# Modify the tomcat6 config file to pick up our preferred version of Java
# and also set the Jenkins home
echo "
JAVA_HOME=\"/usr/java/latest\"
JAVA_OPTS=\"-DJENKINS_HOME=/mnt/vm-rpmbuild/jenkins -Xmx512m\"
" >> /etc/vm-rpmbuild/web/tomcat6.conf

cd /usr/share/tomcat6/webapps/
curl -O http://192.168.100.2/misc/build.war
chown root.tomcat build.war

# ---------------------------------------------------------------


# ---------------------------------------------------------------

# Add some authorized public keys to the system
mkdir /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+YXXQ+LuE2eQSCwrnqsuef6yYRWNGL30w2rRn7CyXsjJ9YA0bvTO6CT7JOOjS1T2m6JD0bhku2bDYYaSNt1elfY+0XlQY7O9R83YSbvxevND7CD1u08wq1+VHDTWPfHf+spokU+G0qwshjaE0ZSIcx86va2RAIa8mQbvFsk6TU0fIU2u6Tx3Lea8ABQfCEGR0u9CYauL1ORZDdh0wUuF3oqL1JUm6OuB6HsigE2glx0dFbSvRAhJygaTine0PXQ6yhnEjvRt5mzxK2e4Qsu+r5lQqQfLKZz+nW22SHNwex8tFdh5o31oO3kmFKip+rkA9X1dVUDpWkhSEExGbp3ft andy@Andrews-MacBook-Pro-2.local" >> /root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmSq6cUPCFbu6/zUSljuDd7ifAlSp7qdIixnKoinJRLPvG2VWdrOiADdSKO18IX/ImNTypN2VkncCB1tmUY5DJv1cbqoRpmKKTMl/5owRtPB006Z2eaqOm2AstGc9y2P/1u/g6CrquyuXM4kno8GEM28/BrOCQTpn0K9JzB41kkqnvrsHgsqYPU2gikIbEE39xPaDTmgJfrELrMq5RjPgQ6UC9cGk/ObCwVQQTWRRxPDe4e+l9tb9wXXGeaxvmLZsdABI5TuTgf1OuvaNrU3kEVHKujifneuMrZ4xRev1DxwiLy2UsK7etBLqqtF5v9Ygl3Ak9uzWnBw0m9U6ChmAEQ== spohna@saic-74886" >> /root/.ssh/authorized_keys
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
metadata_expire=1
gpgcheck=0
cost=1
" > /etc/yum.repos.d/CentOS-Local.repo

) > /root/post_install.log

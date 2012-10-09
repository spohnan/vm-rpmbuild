# Settings that might need to be updated
%define name                  rbuild-base
%define version               1.0
%define buildroot             %{_topdir}/BUILD/%{name}-%{version}-root

# RPM Header info
Summary: Required settings and files for rpmbuild appliance
Name:      %{name}
Version:   %{version}
Release:   %{release}
BuildArch: noarch
BuildRoot: %{buildroot}
Source:    https://github.com/spohnan/vm-rpmbuild/tree/master/admin-scripts/build/rpms/rbuild-base
URL:       https://github.com/spohnan/vm-rpmbuild
License:   MIT

%description
Required settings and files for rpmbuild appliance

%prep
exit 0

%build
exit 0

%install
rm -fr %{buildroot}
cp -R %{_sourcedir}/rbuild-base %{buildroot}

%clean
rm -fr %{buildroot}

%pre
exit 0

%post
# Update build timestamp
echo `date +%Y-%m-%dT%H:%MZ` > %{_sysconfdir}/vm-rpmbuild/build
# Update release
echo %{version} > %{_sysconfdir}/vm-rpmbuild/release

# Can't make this rpm depend on rbuild-login-console as that would set up
# a circular dependency so we're just check for the existence of the file
# it puts in place before calling a restart on the service
if [ -f /etc/init.d/login-console ]; then
    # Update the build timestamp on the login-console screen
    /sbin/service login-console restart
fi

%files

%defattr(755,root,root)
%{_sysconfdir}/vm-rpmbuild
/usr/local/bin/update-rpm-repo.sh
/usr/local/bin/jenkins-update-rpm-repo.sh
/usr/local/bin/prune-old-rpm-versions.sh
/usr/local/bin/build-rpms.sh

%defattr(664,root,root)
%{_sysconfdir}/vm-rpmbuild/build
%{_sysconfdir}/vm-rpmbuild/release

%changelog
* Sun Oct 9 2012 Andrew Spohn <Andy@AndySpohn.com> - 1.0
- First packaging

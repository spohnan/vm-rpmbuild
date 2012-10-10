# Settings that might need to be updated
%define name                  rbuild-ids
%define version               1.0
%define buildroot             %{_topdir}/BUILD/%{name}-%{version}-root

# RPM Header info
Summary: File change detection for rpmbuild appliance
Name:      %{name}
Version:   %{version}
Release:   %{release}
BuildArch: noarch
BuildRoot: %{buildroot}
Source:    https://github.com/spohnan/vm-rpmbuild/tree/master/admin-scripts/build/rpms/rbuild-ids
URL:       https://github.com/spohnan/vm-rpmbuild
License:   MIT
requires:  rbuild-base
requires:  aide

%description
File change detection for rpmbuild appliance. We're using an intrusion detection system
as that does what we need, just really want to show a warning if something has been changed

%prep
exit 0

%build
exit 0

%install
rm -fr %{buildroot}
cp -R %{_sourcedir}/rbuild-ids %{buildroot}

%clean
rm -fr %{buildroot}

%pre
exit 0

%post
exit 0

%files
%defattr(755,root,root)
/etc/cron.daily/run-ids
/etc/vm-rpmbuild/ids
/etc/vm-rpmbuild/ids/aide.conf
/etc/vm-rpmbuild/ids/aide-settings.sh
/etc/vm-rpmbuild/ids/status
/mnt/vm-rpmbuild/ids
/mnt/vm-rpmbuild/ids/logs
/usr/local/bin/check-ids.sh
/usr/local/bin/latest-changes-ids.sh
/usr/local/bin/update-ids-db.sh


%changelog
* Sun Oct 9 2012 Andrew Spohn <Andy@AndySpohn.com> - 1.0
- First packaging

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

%files
%defattr(755,root,root)
%{_sysconfdir}/vm-rpmbuild
%{_sysconfdir}/vm-rpmbuild/build
%{_sysconfdir}/vm-rpmbuild/release
/usr/local/bin/update-rpm-repo.sh

%changelog
* Sun Oct 9 2012 Andrew Spohn <Andy@AndySpohn.com> - 1.0
- First packaging

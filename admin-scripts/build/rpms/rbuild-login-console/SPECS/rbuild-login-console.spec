# Settings that might need to be updated
%define name                  rbuild-login-console
%define version               1.0
%define buildroot             %{_topdir}/BUILD/%{name}-%{version}-root

# RPM Header info
Summary: Login console for rpmbuild appliance
Name:      %{name}
Version:   %{version}
Release:   %{release}
BuildArch: noarch
BuildRoot: %{buildroot}
Source:    https://github.com/spohnan/vm-rpmbuild/tree/master/admin-scripts/build/rpms/rbuild-login-console
URL:       https://github.com/spohnan/vm-rpmbuild
License:   MIT
requires:  rbuild-base

%description
A customized login screen

%prep
exit 0

%build
exit 0

%install
rm -fr %{buildroot}
cp -R %{_sourcedir}/rbuild-login-console %{buildroot}

%clean
rm -fr %{buildroot}

%pre
exit 0

%post
# Update build timestamp
echo `date +%Y-%m-%dT%H:%MZ` > %{_sysconfdir}/vm-rpmbuild/build
/sbin/chkconfig login-console on
/sbin/service login-console start

%files
%defattr(755,root,root)
%{_sysconfdir}/init.d/login-console

%changelog
* Sun Oct 7 2012 Andrew Spohn <Andy@AndySpohn.com> - 1.0
- First packaging

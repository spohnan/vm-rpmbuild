# Settings that might need to be updated
%define name                  rbuild-login-console
%define version               1.0
%define release               1

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

%description
This package manages the trac wiki configuration files as installed for the Vigilant Pursuit (VP) program.

%prep
exit 0

%build
exit 0

%install
exit 0

%clean
exit 0

%pre
exit 0

%files
%defattr(755,root,root)
%{_sysconfdir}/init.d/login-console

%changelog
* Sun Oct 7 2012 Andrew Spohn <Andy@AndySpohn.com> - 1.0
- First packaging

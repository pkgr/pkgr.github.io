---
title: Supported distributions
order: 3
categories:
  - reference
---

Packager.io supports a large variety of target platforms for your packages:

Distribution | Identifier | init system
--- | --- | ---
Ubuntu 14.04 Trusty 64bits | `ubuntu-14.04` | upstart
Ubuntu 12.04 Precise 64bits | `ubuntu-12.04` | upstart
Debian 7 Wheezy 64bits | `debian-7` | sysvinit
CentOS/RHEL 6.x 64bits | `centos-6` | upstart
Fedora 20 64bits | `fedora-20` | sysvinit
Suse Linux Enterprise Server 12 | `sles-12` | sysvinit

Distributions can be enabled or disabled by configuring your `targets` in the [`.pkgr.yml`][pkgr-yml] file.

[pkgr-yml]: ../customizing-the-build/#targets

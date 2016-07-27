---
title: Supported distributions
order: 3
categories:
  - reference
---

Packager.io supports a large variety of target platforms for your packages:

Distribution (64 bits only) | Identifier | init system
--- | --- | ---
Ubuntu 16.04 Xenial | `ubuntu-16.04` | systemd
Ubuntu 14.04 Trusty | `ubuntu-14.04` | upstart
Ubuntu 12.04 Precise | `ubuntu-12.04` | upstart
Debian 8 Jessie | `debian-8` | systemd
Debian 7 Wheezy | `debian-7` | sysvinit
CentOS/RHEL 7.x | `centos-7` | systemd
CentOS/RHEL 6.x | `centos-6` | upstart
Suse Linux Enterprise Server 12 | `sles-12` | sysvinit
Suse Linux Enterprise Server 11 | `sles-11` | sysvinit

Distributions can be enabled or disabled by configuring your `targets` in the [`.pkgr.yml`][pkgr-yml] file.

[pkgr-yml]: ../customizing-the-build/#targets

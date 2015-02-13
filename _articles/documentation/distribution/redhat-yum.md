---
layout: 	page
title: 		Redhat YUM
---

RPM packages are hosted in a YUM repository, which must be added to your list of source repositories on the machine on which you want to install the package.

Specific installation instructions are given directly on the installation page for your application, but the general process is as follows:

1. Add our GPG key to the list of trusted keys

2. Add a new entry to the list of enabled YUM repositories

3. Refresh the package index

You should now be able to `yum install` the package from the new YUM repository you've declared.
---
layout:   page
title:    Getting Started
---

Packager.io is a service that automatically packages your application as a DEB or RPM package, for a number of [target distributions][distributions].

Currently, you can package applications written in [Ruby][ruby], [NodeJS][nodejs], or [Go][go].

The process is as follows:

* [register][register] with your GitHub account.
* [enable one of your applications][enable] that you want to package.
* every time you push new code to your GitHub repository, a [build is launched][build] on our servers. You can also manually launch a build from the user interface.
* during the build process, your code is fetched, and runs through a list of [buildpacks][buildpacks], which take care of fetching all the dependencies required by your application, and then a DEB or RPM package is generated, and hosted in your own [APT or YUM repository][repositories].
* you can now log-in on your servers, and [install your application][install] with a simple `apt-get install` or `yum install`.

Please click on the Next button to proceed to the next chapter of this guide.

[distributions]: ../packaging/distributions.html
[ruby]: ../languages/ruby.html
[nodejs]: ../languages/nodejs.html
[go]: ../languages/go.html
[register]: ./register.html
[enable]: ./enable-application-for-packaging.html
[build]: ./launch-build.html
[install]: ./install-configure-run-package.html
[buildpacks]: ../packaging/buildpacks.html
[repositories]: ../packaging/repositories.html

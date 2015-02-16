---
title:    Launch your first build
order: 3
categories:
  - getting-started
permalink: launch-build/
---

Now that you've [enabled an application][enable-application], you will be greeted with a screen similar to the one below:

[enable-application]: ../enable-application-for-packaging

<img src="{{ site.baseurl }}/static/img/packager-build-now.png" />

Clicking on the **BUILD NOW** button will immediately launch a new build of the application for your default branch.

{{#tip}}

The default branch for a repository is usually the <code>master</code> branch, but it depends on your GitHub settings. You can enable more branches for packaging. See <a href="../releases-and-versions">Releases & Versions</a> for more details.

{{/tip}}

Once a build has started, you'll be able to view the build logs in real-time to follow the progress. Unless specified otherwise, we try to build a package of your application for the latest versions of all the [supported distributions][distributions], but you should always specify the exact targets in your [`.pkgr.yml`][pkgr-yml] file.

<img src="{{ site.baseurl }}/static/img/packager-logs.png" />

Upon completion, a notification email will be sent to the authors and committers of the commit(s) that have been pushed, but only if they are also users of Packager.io (we don't want to annoy people without their permission). You can have a look at our [Notifications][notifications] reference for more settings.

{{#tip}}

You may need to run a few builds before you understand what's missing for your package to properly build (e.g. missing system dependencies required by the libraries you're using, etc.).

Don't be afraid to experiment, it's part of the learning curve. If you're stuck, please send us an email to {{ site.email }}.

{{/tip}}

If you need help packaging your application, head over to the relevant documentation for the languages we support to find more details, and explore example applications:

* [Ruby][ruby]
* [NodeJS][nodejs]
* [Go][go]

[ruby]: ../ruby
[nodejs]: ../nodejs
[go]: ../golang

Once you get a successful build, see the next chapter to learn how to install, configure, and run the application.

[distributions]: ../distributions
[pkgr-yml]: ../pkgr-yml
[notifications]: ../notifications

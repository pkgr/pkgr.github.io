---
layout:   page
title:    Releases & Versions
---

## Releases

You can enable more branches to package in your project settings. Each branch is considered to be a specific release, and packages built from branch A will be isolated from packages built from branch B. This allows you to provide packages at different degrees of stability.

For instance, you may already have two branches in your repository, let's say `master` and `stable`. In `master` you have the most recent code, not necessarily production ready, while the `stable` branch only gets new code once it is considered stable enough.

In that case, you can enable both branches in your project settings, and packages will be built for both branches. Then, you can use the packages from `master` to deploy to staging or let the users living on the edge try out the latest features, while your production servers and lambda users and clients will use the packages from the `stable` release to install your application.

## Versions

Within a Release, packages will be versioned according to:

* the time at which they have been generated
* a version number, based on the latest git tag reachable from the git commit that has been packaged

If a proper tag can't be reached from the commit being packaged, the version number will be set to `0.0.0`. So make sure you always push your tags with `git push --tags`.


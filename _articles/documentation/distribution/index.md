---
layout:   page
title:    Distribution
---

In addition to packaging your application, Packager.io also provides an advanced service to host those packages. As such, DEB and RPM packages are made available so that, respectively, the `apt` and `yum` command line utilities can download the packages from your application directly from the Packager.io servers.

Should you be familiar with the way of setting up and maintaining APT or YUM repositories for your packages, you can also only use our packaging service and host the generated packages on your own servers.

## Repositories

Each GitHub repository that you enabled on Packager.io comes with its own APT and/or YUM repository to host the generated packages for that application. All repositories 

## Securing repositories

All repositories are only available over HTTPS, and they are also signed with our GPG key. This way `apt` or `yum` can verify that the artefacts indeed come from the Packager.io service, and that they have not been altered by a middleman.

## Restricting access to repositories

All paying customers can generate any number of download tokens for their repositories. When a repository is secured with tokens, only the clients who have received such a token can access the repository and download packages. Those tokens can be revoked at any time.

## Analytics

Every time a package is downloaded, we store various data about the download, so that you can see how many times your packages have been downloaded, and the location of the servers performing the download.

We also surface the number of servers which are actively checking for updates, so that you can have a rough idea of how many active servers are using your packages.

For repositories restricted with download tokens we also offer, for each token, a detailed report of the date, location, and exact version number of downloaded packages.
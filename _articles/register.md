---
title: Register with your GitHub account
order: 1
permalink: register/
categories:
  - getting-started
---

Packager.io needs to access the git repository where the code of the application you want to package resides.

For now, the only provider we support is [GitHub][github], so you'll need to have an account set up with them.

If you have a GitHub account, head over to [packager.io][packager-io], and click on the **Sign in** button on the screen. You will be redirected to the GitHub site, which will ask for the permission to share your repository details with us.

<img src="{{ site.baseurl }}/static/img/github-authorize.png" />

{{#warning}}

Due to the nature of GitHub OAuth scopes, we are required to ask for read/write permissions on all your repositories, which is far from ideal. We hope to have access to finer-grained scopes in the future.

In the meantime you can have a look at our <a href="/security" target="_blank">Security</a> and <a href="/privacy" target="_blank">Privacy</a> policies to better understand what we access, and how we ensure that your code stays safe.

{{/warning}}

[packager-io]: https://packager.io/
[github]: https://github.com/

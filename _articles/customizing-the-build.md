---
title: Customizing the build
subtitle: Everything you need to know about the .pkgr.yml file
order: 1
categories:
  - reference
---

{{#intro}}

 To customize the way your package is built, you can add a `.pkgr.yml` file at the root of your project repository. This file will be parsed by Packager when a build is run.

{{/intro}}

You'll find all the available options explained below.

## `targets`

Use this option to specify which distributions to target. Each target accepts a YAML hash of options, which will overwrite any other option defined for all distributions.

{{#tip}}

The available distributions can be found in [Supported distributions][distributions].

By default, packages will be built for `ubuntu-14.04`, `centos-6`, and `debian-7`.

{{/tip}}

Use the distribution name as a key to the `targets` hash, as follows:

```yaml
dependencies:
  - default-dependency-1
  - default-dependency-2
targets:
  ubuntu-12.04:
    # overwrite dependencies only for ubuntu-12.04
    dependencies:
      - other-dependency-1
      - other-dependency-2
  ubuntu-14.04:
  debian-7:
```

If you just want to enable a target without any additional option, you can do as follows:

```yaml
targets:
  ubuntu-14.04:
  centos-6:
```

## `buildpack`

If you want to pass a custom [buildpack][buildpacks] to package your application, you can do so with the `buildpack` configuration option. Though we can not ensure that the resulting package will work. Please do contact us if you run into any issue.

```yaml
buildpack: https://github.com/heroku/some-buildpack#branch
```

## `build_dependencies`

In some cases, some of your app dependencies (e.g. gems with C extensions in the case of Ruby projects) may only be installed if specific development headers are available. To allow for the packaging process to succeed, you must list them with the `build_dependencies` option. This must be specified as a YAML array.

```yaml
build_dependencies:
  - libicu-dev
  - libmagickcore-dev
  - libmagickwand-dev
```

## `crons`

Native packages allow you to easily set up cron jobs, to periodically run tasks for your application.

Let's say you need to run the `rake crons:task1` every hour, here is what you need to do:

1. Create a cron job definition in your repository, for instance in `packaging/crons/my-app-task1`:

  ```bash
  # cat packaging/crons/my-app-task1
  0 * * * * my-app my-app run rake crons:task1 1>&2 >> /var/log/my-app/cron-task1.log
  ```

  This cron task wll run as the `my-app` user (automatically created with your app), and will run the rake task in the context of your application using the [cli][cli].

  Note: You could replace the first `my-app` with `root` if you need to run cron jobs as the `root` user.

2. Declare your cron in the `.pkgr.yml` file:

    ```yaml
    crons:
      - packaging/crons/my-app-task1
    ```

Now, upon installing your package, your cron task will automatically be installed in `/etc/cron.d/my-app-task1`!

## `default_dependencies`

Every package ships with default dependencies for each supported distribution
([example](https://github.com/crohr/pkgr/blob/master/data/dependencies/debian.yml)).
If you don't want them to be added to your packages (e.g. it does not make
sense for Go applications), you can disable them as follows:

```yaml
default_dependencies: false
```

## `dependencies`

If your application requires additional system dependencies to be installed, you can add them with the `dependencies` configuration option.

This must be specified as a YAML array. For instance:

```yaml
dependencies:
  - "libicu44 | libicu42"
  - libpcre3
  - git-core
```

## `user`

The name of the user under which your app processes will be run. If this user does not exist on the target machine, then it will be automatically created. Defaults to your application `name` (taken from Github, which can be overwritten in the app settings).

```yaml
user: "custom-user-name"
```

## `group`

The name of the group under which your app processes will be run. If this group does not exist on the target machine, then it will be automatically created. Defaults to `user`.

```yaml
group: "custom-group-name"
```

## `before_precompile`

{{#warning}}

This option is deprecated. You should use the `before` option.

{{/warning}}

In the case of complex apps, you might need to do a bit of housekeeping before the packaging process can start. This can include creating files or folders that should be present for running the app (but not necessarily checked into the repository). In that case, you can add a bash script anywhere in your repository that does just that, and reference it with the `before_precompile` configuration option:

```yaml
before_precompile: "packaging/debian/setup.sh"
```

## `after_precompile`

{{#warning}}

This option is deprecated. You should use the `after` option.

{{/warning}}

If you need to run a task after the buildpack compilation step is finished, you can provide a path to a file to execute:

```yaml
after_precompile: path/to/file.sh
```

## `before`

Replacement for `before_precompile`, which instead of pointing to a file, must be an array of commands to execute before the packaging process starts. e.g.:

```yaml
before:
  - mv some/file to/path
```

Note that `before_precompile` takes precedence over `before` if both are specified.

## `after`

Replacement for `after_precompile`, which instead of pointing to a file, must be an array of commands to execute after the buildpack compilation step is finished.

Note that `after_precompile` takes precedence over `after` if both are specified.

```yaml
after:
  - cp some/file target
  - rm -rf some/dir
```

## `before_install`

If you need to execute things just before the package is installed or updated on the user's machine, you can specify a `before_install` option, the value being the path to a file in your repository (it must have a shebang, e.g. `#!/usr/bin/env bash`):

```yaml
before_install: "packaging/debian/preinstall.sh"
```

The file will be called with the arguments given to preinstall files for the distribution where the package is being installed. For debian-based distributions, please refer to <https://www.debian.org/doc/debian-policy/ch-maintainerscripts.html>.

## `after_install`

As with `before_install`, you can specify that a file be executed just after the package has been installed or updated on the user's machine:

```yaml
after_install: "packaging/debian/postinstall.sh"
```

The file will be called with the arguments given to postinstall files for the distribution where the package is being installed. For debian-based distributions, please refer to <https://www.debian.org/doc/debian-policy/ch-maintainerscripts.html>.

## `cli`

By default, all packages come with a [command-line utility][cli] to manage your application. In some cases it may not be needed, for instance if the application you're packaging is itself a command-line utility with its own executable.

If you don't want the built-in CLI to interfere, you can delegate all calls to your own executable by specifying:

```yaml
cli: bin/my-cli
```

If you don't want any CLI to be installed at all, then put:

```yaml
cli: false
```

## `env`

You can set environment variables for use during the packaging process. To do so, use the `env` configuration option:

```yaml
env:
  - HELLO=world
```

## `notifications`

Whenever a build fails or is successful on a branch, the default is to send an email notification to the authors and committers of the relevant commits (but only those who have also an account on Packager.io).

If you wish to disable all email notifications, add the following to your .pkgr.yml file:

```yaml
notifications: false
```

If you wish to notify a specific set of people, add them to the list of recipients. Only them will receive notifications:

```yaml
notifications
  recipients:
    - one@example.com
    - other@example.com
```

## `runner`

By default, Debian 7 packages come with sysv init scripts (the ones in `/etc/init.d/`), because that distribution does not support upstart scripts by default. If you wish to force the use of upstart scripts, then you can set the `runner` configuration variable to `upstart-1.5` in your `.pkgr.yml` file:

```yaml
targets:
  debian-7:
    runner: upstart-1.5
```

On the contrary, upstart scripts are generated by default for Ubuntu 12.04, Ubuntu 14.04, and CentOS 6.x packages, but you can change this to use classic sysv init scripts by doing the following:

```yaml
targets:
  ubuntu-12.04:
    runner: sysv-lsb-3.1
```

Note that sysvinit scripts do not support the respawning of crashed processes.

## `services`

Sometimes third-party software is required for the packaging of your app to be successful. For instance, some Rails apps require a database to be present when precompiling assets, or even an instance of redis. If you need to have such services started automatically for you before the packaging process starts, you can easily specify them:

```yaml
services:
  - postgres
  - redis
```

They will be made available on their default port and address, and will automatically be shut down when your build finishes.

Currently, you can specify the following services (please contact us if you need anything specific):

* PostgreSQL
* Redis

[buildpacks]: ../buildpacks/
[distributions]: ../distributions/
[cli]: ../cli/

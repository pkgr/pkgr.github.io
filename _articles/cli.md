---
title: CLI
subtitle: A simple way to manage your application
categories:
  - reference
order: 7
---

To simplify the management of your application once it is installed on a server, a command line utility ships with all packages. By default it has the same name than your package, and is available only to the `root` user.

For instance, assuming you've installed an application named `example-sinatra-app`:

``` command-line
$ sudo example-sinatra-app
> Usage:
>  example-sinatra-app run COMMAND [options]
>  example-sinatra-app scale TYPE=NUM
>  example-sinatra-app logs [--tail|-n NUMBER]
>  example-sinatra-app config:get VAR
>  example-sinatra-app config:set VAR=VALUE
>  example-sinatra-app configure
>  example-sinatra-app reconfigure
```

## `config:set`

Allows to set an [environment variable][env-variables] for your application:

``` command-line
$ sudo example-sinatra-app config:set <em>PORT=6789</em>
```

## `config:get`

Displays the value of an environment variable. Exits with the code `1` if the variable does not exist.

``` command-line
$ sudo example-sinatra-app config:get <em>PORT</em>
> 6789
```

``` command-line
$ sudo example-sinatra-app config:get <em>DOESNOTEXIST</em>
# outputs nothing, and exits with 1
```

## `config`

Displays the full list of environment variables set for your application:

``` command-line
$ sudo example-sinatra-app config
> APP_GROUP=example-sinatra-app
> APP_HOME=/opt/example-sinatra-app
> APP_NAME=example-sinatra-app
> APP_RUNNER_CLI=initctl
> APP_RUNNER_TYPE=upstart
> APP_SAFE_NAME=example_sinatra_app
> APP_USER=example-sinatra-app
> ...
```

## `run`

Run a one-off process in the context of your application, in the foreground:

``` command-line
$ sudo example-sinatra-app run web
> Puma 2.9.2 starting...
> * Min threads: 0, max threads: 16
> * Environment: production
> * Listening on tcp://0.0.0.0:6789
> == Sinatra/1.4.5 has taken the stage on 6789 for production with backup from Puma
```

You can also run any other script (the application context -- e.g. `PATH` -- will be made available to them):

``` command-line
$ sudo example-sinatra-app run ./path/to/script
```

## `scale`

Run a process in the background, and generate init scripts for your platform:

``` command-line
$ sudo example-sinatra-app scale <em>web=1</em>
> Scaling up...
> --> done.
```

Which allows you to manage your app processes with the `service` system utility (and the services will be launched when your system starts/reboots):

``` command-line
$ sudo service example-sinatra-app <em>[start|stop|status|restart]</em>
```

To disable the process completely (including init scripts):

``` command-line
$ sudo example-sinatra-app scale <em>web=0</em>
> Scaling down...
> --> done.
```

To scale (up or down) multiple processes at once:

``` command-line
$ sudo example-sinatra-app scale web=1 worker=2
```

{{#tip}}

You can find more details about processes and how to declare them in the [Procfile documentation][procfile].

{{/tip}}

## `logs`

Displays your application's logs (stored in `/var/log/app-name/`):

``` command-line
$ sudo example-sinatra-app logs
```

You can also tail:

``` command-line
$ sudo example-sinatra-app logs --tail
```

[procfile]: ../procfile/
[env-variables]: ../environment-variables/

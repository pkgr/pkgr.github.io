---
title:    Process types (Procfile)
order: 2
categories:
  - reference
---

## Process types and the Procfile

{{#intro}}

Procfiles were introduced by Heroku as a mechanism for declaring what commands are run by your application. See [this link](https://devcenter.heroku.com/articles/procfile) for more details.

{{/intro}}

Process types are declared in a specific file named `Procfile`. It comes from the Heroku way of doing things, and is a simple text-based file spercifying a mapping between process names, and how those process are launched.

For instance, most web applications have at least a `web` process, which is usually a server daemon being able to serve HTTP requests for the application. Applications may also have a `worker` process, which is used to run background job processors, such as [Sidekiq](http://sidekiq.org/) or [Resque](https://github.com/resque/resque) in the Ruby world.

Process names can be arbitrary, although it is expected that the `web` process specifies the main process of your application.

## Launching processes

Any process declared in the `Procfile` can be launched using the [dedicated command line tool][command-line-tool] that comes with each package. For instance, assuming you have declared the following `Procfile`:

[command-line-tool]: ../command-line-tool

```bash
web: bundle exec rails s -p $PORT
worker: bundle exec sidekiq
```

You would be able to launch any of the `web` or `worker` processes in two way:

### 1) As a foreground process

``` command-line
$ sudo my-app run web
```

To quit the process, you would hit CTRL-C.

### 2) As a daemonized process

``` command-line
$ sudo my-app scale web=1
```

Using the `scale` command will register the process with your init system.

As such, to manage the process, you would then use the `service` utility from your system:

``` command-line
$ sudo service my-app-web stop|start|restart|status
```


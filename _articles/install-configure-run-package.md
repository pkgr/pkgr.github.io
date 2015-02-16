---
title: Install, configure, and run your packaged application
categories:
  - getting-started
order: 4
---

If the packaging [build process][build] successfully completed, you'll be able to see the Installation page, with instructions on how to deploy your application using `apt`, `yum` or `zypper`, depending on the distributions you've targeted.

{{#warning}}

In this chapter, we're assuming we've packaged a simple Ruby application, available at https://github.com/pkgr/example-sinatra-app, with the resulting packages available at https://packager.io/gh/pkgr/example-sinatra-app.

{{/warning}}

We'll install and configure the application on a Ubuntu 14.04 LTS server.

{{#tip}}

You can fork this example application to test our service. This is a good way to get up and running quickly, before trying to package your own application.

{{/tip}}

## Install the application

Following the instructions given in the [Installation page][installation-example-app] of this application, here is how you would install the package on your server:

[installation-example-app]: https://packager.io/gh/pkgr/example-sinatra-app/install

``` command-line
$ wget -qO - https://deb.packager.io/key | sudo apt-key add -
> OK

$ echo "deb https://deb.packager.io/gh/pkgr/example-sinatra-app trusty master" | sudo tee /etc/apt/sources.list.d/example-sinatra-app.list
> deb https://deb.packager.io/gh/pkgr/example-sinatra-app trusty master

$ sudo apt-get update
> Ign http://archive.ubuntu.com trusty InRelease         
> Ign http://archive.ubuntu.com trusty-updates InRelease 
> Ign http://archive.ubuntu.com trusty-security InRelease
> Hit http://archive.ubuntu.com trusty Release.gpg       
> Hit http://archive.ubuntu.com trusty-updates Release.gp
> Hit http://archive.ubuntu.com trusty-security Release.g
> Hit http://archive.ubuntu.com trusty Release           
> Hit http://archive.ubuntu.com trusty-updates Release   
> Hit http://archive.ubuntu.com trusty-security Release  
> Get:1 https://deb.packager.io trusty InRelease         
> Ign https://deb.packager.io trusty InRelease         

$ sudo apt-get install example-sinatra-app
> Reading package lists... Done
> Building dependency tree       
> Reading state information... Done
> The following extra packages will be installed:
>   libpq5 libreadline5 libxml2 libxslt1.1 mysql-common sgml-base xml-core
> Suggested packages:
>   sgml-base-doc debhelper
> The following NEW packages will be installed:
>   example-sinatra-app libpq5 libreadline5 libxml2 libxslt1.1 mysql-common
>   sgml-base xml-core
> 0 upgraded, 8 newly installed, 0 to remove and 6 not upgraded.
> Need to get 19.2 MB of archives.
> After this operation, 71.8 MB of additional disk space will be used.
> Do you want to continue? [Y/n] 
```

Let's dissect what the above instructions do:

1. The first command adds our GPG key to the list of the keys that your system recognizes. This makes sure that all packages downloaded by your package manager can be verified as coming from us.

2. The second command adds an additional APT repository to your system, from where you will get packages for your application. Notice the use of HTTPS to secure the communication between your servers and ours.

3. Finally, the third and fourth commands are the usual way of installing packages on Debian based systems, by first updating the list of packages available, and then installing it.

Once it's installed, you can verify that everything works as expected, thanks to the command line utility that ships with all packages (named after your application's name). For instance, let's check that our application has access to a Ruby runtime:

``` command-line
$ sudo example-sinatra-app run ruby -v
> ruby 2.1.5p273 (2014-11-13 revision 48405) [x86_64-linux]
```

Then, we can check that the `web` process (declared in the application's [Procfile][procfile]) can run without issues, in foreground mode:

[procfile]: https://github.com/pkgr/example-sinatra-app/blob/master/Procfile

``` command-line
$ sudo example-sinatra-app run web
> Puma 2.9.2 starting...
> * Min threads: 0, max threads: 16
> * Environment: production
> * Listening on tcp://0.0.0.0:6000
> == Sinatra/1.4.5 has taken the stage on 6000 for production with backup from Puma
```

Or, you can start the application in the background by generating init script for your system:

``` command-line
$ sudo example-sinatra-app scale web=1
> Scaling up...
> example-sinatra-app-web-1 start/running, process 10443
> example-sinatra-app-web start/running
> example-sinatra-app start/running
> --> done.
```

{{#tip}}

You can generate init scripts for any of the processes declared in your `Procfile`. For instance, most of the complex apps have some kind of `worker` process to start alongside their main `web` process. In that case, you would scale both processes by doing `$ sudo example-sinatra-app scale web=1 worker=1`.

{{/tip}}

It's now time to check that the application is running correctly:

``` command-line
$ curl http://localhost:6000/
> Hello, world. Here is the content of HELLO_URL (https://api.github.com/rate_limit): "{\"resources\":{\"core\":{\"limit\":60,\"remaining\":60,\"reset\":1416572299},\"search\":{\"limit\":10,\"remaining\":10,\"reset\":1416568759}},\"rate\":{\"limit\":60,\"remaining\":60,\"reset\":1416572299}}"
```

Success!

## Configure your application

You can set environment variables for your application by using the `config:set` command of the command-line tool.

For instance, our simple application will fetch the HTML content of a URL given as the `HELLO_URL` environment variable, which we can alter by doing:

``` command-line
$ sudo example-sinatra-app config:set HELLO_URL=<em>https://google.com</em>
```

We can also alter the port on which the application listens (by default, `6000`):

``` command-line
$ sudo example-sinatra-app config:set PORT=<em>8000</em>
```

Don't forget to restart the application after making changes to the configuration:

``` command-line
$ sudo service example-sinatra-app restart
> example-sinatra-app stop/waiting
> example-sinatra-app start/running
```

We can now access the application on port 8000, and verify that the application returns the `HELLO_URL` we've set:

``` command-line
$ curl localhost:8000
> Hello, world. Here is the content of HELLO_URL (https://google.com): "&lt;HTML>&lt;HEAD>&lt;meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">\n&lt;TITLE>302 Moved&lt;/TITLE>&lt;/HEAD>&lt;BODY>\n&lt;H1&gt;302 Moved&lt;/H1&gt;\nThe document has moved\n&lt;A HREF=\"https://www.google.fr/?gfe_rd=cr&amp;ei=1SFvVLDYJsXI8gfl5YBI\">here&lt;/A>.\r\n&lt;/BODY>&lt;/HTML>\r\n"
```

{{#tip}}

See the <a href="../packaging/environment-variables.html">list of all default environment variables</a> set for your application.

{{/tip}}

At any time, you can see the full list of environment variables available to your application by using the `config` command:

``` command-line
$ sudo example-sinatra-app config
> APP_GROUP=example-sinatra-app
> APP_HOME=/opt/example-sinatra-app
> APP_NAME=example-sinatra-app
> APP_RUNNER_CLI=initctl
> APP_RUNNER_TYPE=upstart
> APP_SAFE_NAME=example_sinatra_app
> APP_USER=example-sinatra-app
> GEM_PATH=/opt/example-sinatra-app/vendor/bundle/ruby/2.1.0:
> HELLO_URL=https://google.com
> HOME=/home/example-sinatra-app
> LANG=en_US.UTF-8
> PATH=/opt/example-sinatra-app/bin:/opt/example-sinatra-app/vendor/bundle/bin:/opt/example-sinatra-app/vendor/bundle/ruby/2.1.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin
> PORT=8000
> PWD=/opt/example-sinatra-app
> RACK_ENV=production
```

## Run your application

As we've seen in the previous section, you can generate init scripts for you system by using the `scale` command:

``` command-line
$ sudo example-sinatra-app scale <em>PROCESS=NUM</em>
```

Once it is done, you have now access to the usual commands:

``` command-line
$ sudo service example-sinatra-app status
$ sudo service example-sinatra-app stop
$ sudo service example-sinatra-app start
$ sudo service example-sinatra-app restart
```

If you have started multiple processes, you can also stop/start/restart process types separately, for instance if you just want to restart the `web` process(es):

``` command-line
$ sudo service example-sinatra-app-web <em>[status|start|stop|restart]</em>
```

You can access the logs of your application with:

``` command-line
$ sudo example-sinatra-app logs # --tail
> == Sinatra has ended his set (crowd applauds)
> Puma 2.9.2 starting...
> * Min threads: 0, max threads: 16
> * Environment: production
> * Listening on tcp://0.0.0.0:8000
> == Sinatra/1.4.5 has taken the stage on 8000 for production with backup from Puma
> 127.0.0.1 - - [21/Nov/2014 11:28:21] "GET / HTTP/1.1" 200 343 0.0984
```

Those logs will be automatically rotated thanks to the `logrotate` file installed by the package.

Finally, you can run arbitrary scripts in the **context of your application** by using the `run` command. Some examples would be:

``` command-line
$ sudo example-sinatra-app run console
$ sudo example-sinatra-app run rake
$ sudo example-sinatra-app run ./scripts/your-custom-script
$ sudo example-sinatra-app run ruby -e 'puts "hello"'
```

You can even launch a shell in the context of your app by doing:

``` command-line
$ sudo example-sinatra-app run bash
> example-sinatra-app@precise64:/opt/example-sinatra-app$ ls -al .
> total 60
> drwxr-xr-x  7 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 .
> drwxr-xr-x 14 vagrant             vagrant             4096 Nov 21 11:12 ..
> drwxr-xr-x  2 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 bin
> drwxr-xr-x  2 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 .bundle
> -rw-r--r--  1 example-sinatra-app example-sinatra-app  111 Nov 21 11:03 Gemfile
> -rw-r--r--  1 example-sinatra-app example-sinatra-app  494 Nov 21 11:03 Gemfile.lock
> lrwxrwxrwx  1 root                root                  28 Nov 21 11:12 log -> /var/log/example-sinatra-app
> -rw-r--r--  1 example-sinatra-app example-sinatra-app   65 Nov 21 11:03 .pkgr.yml
> -rw-r--r--  1 example-sinatra-app example-sinatra-app   46 Nov 21 11:03 Procfile
> drwxr-xr-x  2 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 .profile.d
> -rw-r--r--  1 example-sinatra-app example-sinatra-app  439 Nov 21 11:03 README.md
> -rw-r--r--  1 example-sinatra-app example-sinatra-app  191 Nov 21 11:03 .release
> -rw-r--r--  1 example-sinatra-app example-sinatra-app    6 Nov 21 11:03 .ruby-version
> drwxr-xr-x  2 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 tmp
> drwxr-xr-x  6 example-sinatra-app example-sinatra-app 4096 Nov 21 11:12 vendor
> -rw-r--r--  1 example-sinatra-app example-sinatra-app  360 Nov 21 11:03 web.rb
```

## Going further

This concludes the getting started guide. You can find out more about packaging your application using a guide dedicated to your language:

* [Ruby][ruby]
* [NodeJS][nodejs]
* [Go][go]

[ruby]: ../ruby
[nodejs]: ../nodejs
[go]: ../golang

Happy packaging!

[build]: ../launch-build

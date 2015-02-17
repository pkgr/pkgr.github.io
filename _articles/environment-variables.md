---
title: Environment variables
categories:
  - reference
order: 6
---

Here is the list of the environment varialbes that will be available to your application:

Name | Example value | Description
--- | --- | ---
`APP_NAME` | `example-sinatra-app` | The name of your application (i.e. package name)
`APP_HOME` | `/opt/example-sinatra-app` | The directory where your application is installed
`APP_USER` | `example-sinatra-app` | The user under which your app will run (default=`APP_NAME`)
`APP_GROUP` | `example-sinatra-app` | The group under which your app will run (default=`APP_USER`)
`APP_SAFE_NAME` | `example_sinatra_app` | A somewhat safer name to use in various context. Only alphanumerical characters and underscores
`HOME` | `/home/example-sinatra-app` | The home directory of your app
`PORT` | `6000` | The port where the first web process of your application will listen
`PATH` | `/opt/example-sinatra-app/bin:/opt/example-sinatra-app/vendor/bundle/bin:...:/usr/sbin` | An updated PATH for your application

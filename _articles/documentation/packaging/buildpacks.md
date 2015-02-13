---
layout:         page
title:          Buildpacks
---

## What's a buildpack?

The concept of buildpack was introduced by Heroku. It is a simple API to define what needs to be done to generate a self-contained version of an application, ready to be deployed. It has three parts:

* a detection step, where the buildpack attempts to find out whether it can process the application (e.g. the Ruby buildpack checks whether a `Gemfile` exists, among other things).

* a compilation step, where the buildpack will download dependencies, launch tasks, and generally make everything needed to "compile" the application into a self-contained artefact.

* a release step, which is used to set environment variables and various other things needed by the application to run.

You can find more about the Buildpack API on the Heroku website.

## Officially supported buildpacks

* Ruby: the buildpack used to package Ruby applications (Rails, Sinatra, plain Ruby, etc).

* NodeJS: the buildpack used to package NodeJS applications.

* Go: the buildpack used to package Go applications.

* Noop: as the name implies, the Noop buildpack does nothing. Use this if you just want to have a repository packaged, without any processing (e.g. static website, or binary artefacts).

## Custom buildpacks

One of the benefits of having a well-defined buildpack API is that you can create one yourself, and use it as the source buildpack for your application. For instance, although C++ applications are not yet officially supported, you could create a buildpack that adds the necessary steps to compile the code and declare the relevant [process types][procfile].

[procfile]: ../procfile.html

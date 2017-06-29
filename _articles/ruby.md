---
title: Ruby
order: 1
categories:
  - languages
---

## Detection

A Ruby application is detected when it has a `Gemfile` file in the root
directory. If your application has no dependencies, it should include an empty
`Gemfile` file.

## MRI Ruby versions

All MRI Ruby versions 1.9+ and 2.+ are supported. Newer versions are
automatically compiled on-demand if you ask for them.

Your version will either default to `2.3.4`, or the version you've specified in your `Gemfile`. For instance:

``` command-line
$ cat Gemfile
source "https://rubygems.org"

ruby "<em>2.3.0<em>"

# rest of your Gemfile
```

The most recent versions we officially support are as follow:

Ruby version | Rubygems version
--- | ---
`2.4.1` patchlevel `111` | `2.6.11`
`2.3.4` patchlevel `301` | `2.5.2`
`2.2.7` patchlevel `470` | `2.4.5.2`

Generally, you should follow the guidelines outlined in this [Heroku](https://devcenter.heroku.com/articles/ruby-support#ruby-versions) article.

## JRuby versions

JRuby versions are no longer supported at the moment.

## Example applications

* [OpenProject](https://packager.io/gh/opf/openproject), the web-based project management system.
* [Gitlab](https://packager.io/gh/gitlabhq/gitlabhq), the Open source software to collaborate on code.
* [Discourse](https://packager.io/gh/pkgr/discourse), the platform for community discussion.
* [example-sinatra-app](https://packager.io/gh/pkgr/example-sinatra-app), a really simple sinatra app to get you started.

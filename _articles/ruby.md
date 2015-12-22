---
title: Ruby
order: 1
categories:
  - languages
---

## Detection

A Ruby application is detected when it has a `Gemfile` file in the root directory. If your application has no dependencies, it should include an empty `Gemfile` file.

## MRI Ruby versions

Ruby version | Rubygems version
--- | ---
`2.2.4` patchlevel `230` | `2.4.5.1`
`2.1.8` patchlevel `440` | `2.2.5`
`2.0.0` patchlevel `648` | `2.0.14.1`
`1.9.3` patchlevel `551` | `1.8.23.2`

Your version will either default to `2.0.0`, or the version you've specified in your `Gemfile`. For instance:

``` command-line
$ cat Gemfile
source "https://rubygems.org"

ruby "<em>2.2.2<em>"

# rest of your Gemfile
```

## JRuby versions

Ruby version | JRuby version
--- | ---
`2.0.0` | `1.7.11`
`1.9.3` | `1.7.11`
`2.0.0` | `1.7.10`
`1.9.3` | `1.7.10`
`2.0.0` | `1.7.9`
`1.9.3` | `1.7.9`
`2.0.0` | `1.7.8`
`1.9.3` | `1.7.8`
`1.9.3` | `1.7.6`
`2.0.0` | `1.7.6`
`2.0.0` | `1.7.5`
`1.9.3` | `1.7.5`

For specifying non MRI ruby engines, you'll need to use the `:engine` and `:engine_version` options. You can specify JRuby by using the following line:

``` command-line
$ cat Gemfile
source "https://rubygems.org"

ruby "<em>1.9.3</em>", :engine => "<em>jruby</em>", :engine_version => "<em>1.7.8</em>"
```

## Example applications

* [OpenProject](https://packager.io/gh/opf/openproject), the web-based project management system.
* [Gitlab](https://packager.io/gh/gitlabhq/gitlabhq), the Open source software to collaborate on code.
* [Discourse](https://packager.io/gh/pkgr/discourse), the platform for community discussion.
* [example-sinatra-app](https://packager.io/gh/pkgr/example-sinatra-app), a really simple sinatra app to get you started.

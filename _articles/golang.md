---
title: Go
order: 3
categories:
  - languages
---

## Detection

A Go application will be detected if it contains a `.go` file.

## Requirements

Your application should have either:

* a `.godir` file containing the name of your application. For instance, if the name of your application is `example-app`:

``` command-line
$ cat .godir
> example-app
```

* or, it should use [godep](https://github.com/kr/godep) to manage dependencies, and you must include the generated `Godep` directory in your git repository.

See the [Go buildpack documentation](https://github.com/kr/heroku-buildpack-go) for more details.

## Example applications

* [Gogs](https://packager.io/gh/pkgr/gogs) (Go Git Service), the painless self-hosted Git Service written in Go.
* [example-go-app](https://packager.io/gh/pkgr/example-go-app), a simple Go application to get you started.

---
title: Go
order: 3
categories:
  - languages
---

## Detection

A Go application will be detected if it contains a `.go` file.

## Requirements

Your application must have:

* a `.godir` file containing the name of your application. For instance, if the name of your application is `example-app`:

``` command-line
$ cat .godir
> example-app
```

Note: [Godep](https://github.com/kr/godep) is not supported at the moment. If your application is using it, you should add a `before` step in your `.pkgr.yml` that removes it before the packaging process starts:

```
before:
  - rm -rf Godep/
```

See the [Go buildpack documentation](https://github.com/kr/heroku-buildpack-go) for more details.

## Example applications

* [Gogs](https://packager.io/gh/pkgr/gogs) (Go Git Service), the painless self-hosted Git Service written in Go.
* [example-go-app](https://packager.io/gh/pkgr/example-go-app), a simple Go application to get you started.

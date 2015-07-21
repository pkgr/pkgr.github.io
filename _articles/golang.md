---
title: Go
order: 3
categories:
  - languages
---

## Detection

A Go application will be detected if it contains a `.go` file.

## Requirements

The Go buildpack allows you to specify and install your dependencies using one of two methods, `godep` or `go get`. The recommended method is to use `godep`, which saves application dependencies into the git repo so that the application can be reproducibly packaged.

### godep

To save dependencies using godep, run `godep save` in your app directory and commit the `Godeps` directory. When a package will be built, the Go packages in the `Godeps` directory will be used.

[godep]: https://github.com/kr/godep

### go get

A `.godir` file must exist in the root of the repository if you are not using godep. This file must contain the full package path of your application, which will be used to find packages and name the app binary. For example, a `.godir` file containing the path `github.com/crohr/example-go` with a main package in the root will result in a binary called `example-go`.

``` command-line
$ cat .godir
> github.com/crohr/example-go
```

See the [Go buildpack documentation](https://github.com/kr/heroku-buildpack-go) for more details.

If you need to rename the compiled binary at the end of the process (because it would conflict with the built-in CLI tool that ships with your package), you can do so using an `after` step:

``` command-line
$ cat .pkgr.yml
> after:
>   - mv bin/example-go bin/web
```

And then in your `Procfile`:

``` command-line
$ cat Procfile
> web: bin/web
```

## Example applications

* [Gogs](https://packager.io/gh/pkgr/gogs) (Go Git Service), the painless self-hosted Git Service written in Go.
* [example-go-app](https://packager.io/gh/pkgr/example-go-app), a simple Go application to get you started.

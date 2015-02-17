---
title: APT & HTTPS
categories:
  - tips
---

If you encounter the following error when doing `apt-get update` (for instance, before installing a package):

```
The method driver /usr/lib/apt/methods/https could not be found
```

Then it means that you lack the `apt-transport-https` package. You can install it by doing:

``` command-line
$ sudo apt-get install apt-transport-https
```

{{#warning}}

If you have already added an HTTPS enabled repository in your `/etc/apt/sources.list.d/` folder, then you'll need to remove it first.

{{/warning}}

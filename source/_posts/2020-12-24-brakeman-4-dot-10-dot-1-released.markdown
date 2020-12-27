---
layout: post
title: "Brakeman 4.10.1 Released"
date: 2020-12-24 12:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This releases fixes Ruby 3.0 compatibility (meaning running under 3.0, new syntax is not supported yet).

_Changes since 4.10.1:_

* Declare REXML as a dependency (Ruby 3.0 compatibility)
* Use `Sexp#sexp_body` instead of `Sexp#[..]` (Ruby 3.0 compatibility)
* Prevent render loops when template names are absolute paths ([#1536](https://github.com/presidentbeef/brakeman/issues/1536))
* Ensure RubyParser is passed file path as a String ([#1534](https://github.com/presidentbeef/brakeman/issues/1534))
* Support new Haml 5.2.0 escaping method ([#1517](https://github.com/presidentbeef/brakeman/issues/1517))

### REXML as an Explicit Dependency 

In Ruby 3.0, REXML has become a 'bundled' gem. It is distributed with Ruby, but if Bundler is involved then it needs to be declared as an explicit dependency.

If you like minimal dependencies, you can always use the `brakeman-min` gem which declares only strict dependencies.

([changes](https://github.com/presidentbeef/brakeman/pull/1538))

### Avoid Slicing with Sexp#[]

`Sexp` subclasses from `Array`, and `Array` no longer returns subclasses from methods that create new arrays.

Brakeman was unfortunately using `Sexp#[]` with ranges (e.g. `s(:a, :b, :c)[1..-1]`), which runs into this behavior.
Happily, the `Sexp#sexp_body` method already exists to properly slice and return a `Sexp`.

([changes](https://github.com/presidentbeef/brakeman/pull/1538))

### Recursive Renders with Absolute Paths

Brakeman has long been able to detect recursive render loops, but that detection did not work if the partial name was an 'absolute' path.

This is now fixed!

([changes](https://github.com/presidentbeef/brakeman/pull/1537))

### Ensure RubyParser Path is a String

In some cases, the parser was given a `Brakeman::FilePath` for the file name.
This only caused an issue in some weird corner cases, but it was wrong nonetheless.

Now `Brakeman::FileParser` will ensure the file name is passed as a string.

([changes](https://github.com/presidentbeef/brakeman/pull/1535))

### Support Haml 5.2

Haml 5.2.0 introduced a new method for escaping output, which caused some false positives.

_(Note this was avoided in Brakeman 4.10.0 by bundling an earlier version of Haml.)_

([changes](https://github.com/presidentbeef/brakeman/pull/1518))

### Checksums

The SHA256 sums for this release are:

    e40451080554884a63d73a2933c36518a3cf7a2bb471e6d864ce39a9d3455c98  brakeman-4.10.1.gem
    ec69e04e087b74862629e952d7817dd7b73e30810166e01d69d24d7164101455  brakeman-lib-4.10.1.gem
    3deee68eadd8eb6850254a8e753d6bbe933194c883f12a2455bdf5fd97b1eba2  brakeman-min-4.10.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


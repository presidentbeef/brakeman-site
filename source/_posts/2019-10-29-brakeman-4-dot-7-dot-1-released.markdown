---
layout: post
title: "Brakeman 4.7.1 Released"
date: 2019-10-14 16:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release includes a security fix in a dependency; please see below.

_Changes since 4.7.0:_

* Address file permission issues in bundled `ruby_parser-legacy`
* Sort text report by file and line ([Jacob Evelyn](https://github.com/JacobEvelyn))
* Catch reverse tabnabbing with `:_blank` symbol ([Jacob Evelyn](https://github.com/JacobEvelyn))
* Convert `s(:lambda)` to `s(:call)` in `Sexp#block_call` ([#1410](https://github.com/presidentbeef/brakeman/issues/1410))
* Check string length against limit before joining
* Fix flaky rails4 test ([Adam Kiczula](https://github.com/adamkiczula))
* Fix errors from frozen `Symbol#to_s` in Ruby 2.7
* Add release dates to each version in CHANGES ([TheSpartan1980](https://github.com/TheSpartan1980))

### File Permissions

A security issue [was reported for the `ruby_parser-legacy` gem](https://github.com/zenspider/ruby_parser-legacy/issues/1), where some files are installed with world-writable permissions.
This would allow any user on the system to edit code which would then be executed by Brakeman (or other dependent libraries) when loading the `ruby_parser-legacy` gem.

In this release of the `brakeman` gem, the permissions on these files have been corrected.
However, there has not been a fixed release of `ruby_parser-legacy` yet, so the `brakeman-lib` and `brakeman-min` gems are still affected.

### Default Report Format Sorting

Warnings in the default text report are now sorted by file and line number as well as confidence and category, thanks to [Jacob Evelyn](https://github.com/JacobEvelyn). 


([changes](https://github.com/presidentbeef/brakeman/pull/1412))

### Reverse Tabnabbing

[Jacob Evelyn](https://github.com/JacobEvelyn) also updated the reverse tabnabbing check to match links created with `target: :_blank`.


([changes](https://github.com/presidentbeef/brakeman/pull/1411))

### Stabby Lambdas

`ruby_parser` 3.14.0 changed the AST representation of `->{}` lambdas, and Brakeman needed to adjust.

([changes](https://github.com/presidentbeef/brakeman/pull/1415))

### String Length Limit

Brakeman now checks the resulting length of joining two strings (e.g., `"blah" + "blah blah"`) _before_ joining them.
If the joined string would be longer than 50 characters, the strings are not joined.

Note the only change is when the length is checked, the limit was already in place.

([changes](https://github.com/presidentbeef/brakeman/pull/1421))

### Flaky Test Fixed

[Adam Kiczula](https://github.com/adamkiczula) fixed an intermittently-failing test in the Brakeman test suite that had been
plaguing CI builds for a long time. Thanks!


([changes](https://github.com/presidentbeef/brakeman/pull/1419))

### Ruby 2.7 Frozen Strings

In Ruby 2.7, symbols and some other constant values (`true`/`false`, etc.) will return frozen strings.
This affected Brakeman in only minor ways, but it is fixed now in preparation for Ruby 2.7.

([changes](https://github.com/presidentbeef/brakeman/pull/1420))

### Release Dates in Changelog

Brakeman's [changelog](https://github.com/presidentbeef/brakeman/blob/master/CHANGES.md) now includes release dates thanks to [TheSpartan1980](https://github.com/TheSpartan1980).

([changes](https://github.com/presidentbeef/brakeman/pull/1418))

### Checksums

The SHA256 sums for this release are:

    cdc6f4c86b5b35b5e94798cf443909385aa1b79235da8e1ee1fd4381acf03691  brakeman-4.7.1.gem
    2f7a7a6d79b1e5b8c6a390e04642e987c56cced2c8be3d63a1250f7bbc9e504d  brakeman-lib-4.7.1.gem
    598431f6bfc90b119fc6883ead7896c1718ba5d9a0e0450893c3e628a6c8e7b0  brakeman-min-4.7.1.gem


### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


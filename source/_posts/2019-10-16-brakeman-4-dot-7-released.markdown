---
layout: post
title: "Brakeman 4.7.0 Released"
date: 2019-10-14 16:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release updates Haml support to Haml 5.x!

_Changes since 4.6.1:_

* Update Haml support to Haml 5.x ([#1044](https://github.com/presidentbeef/brakeman/issues/1044))
* Catch shell injection from `-c` shell commands ([Jacob Evelyn](https://github.com/JacobEvelyn))
* Correctly handle non-symbols in `CheckCookieSerialization` ([Phil Turnbull](https://github.com/philipturnbull))
* Refactor `Brakeman::Differ#second_pass` ([Benoit Côté-Jodoin](https://github.com/Becojo))
* Fix `version_between?` ([Andrey Glushkov](https://github.com/aglushkov))
* Ignore interpolation in `%W[]` ([#1399](https://github.com/presidentbeef/brakeman/issues/1399))
* Ignore `form_for` for XSS check

### Haml Support Update

Haml 5 introduced a completely different "compiled" format, so adding support was a significant effort taking a few months to complete.
Due to the large number of changes, you may expect some changes to warnings for Haml templates.

Please report any bugs or odd behavior with Haml templates!

Haml 3.x and 4.x are no longer supported, although in general Haml is mostly backwards-compatible.

([changes](https://github.com/presidentbeef/brakeman/pull/1397))

### Shell Commands

[Jacob Evelyn](https://github.com/JacobEvelyn) added support for detecting command injection with `-c` in known-dangerous commands (such as `bash` or `echo`).

An example of dangerous code would be:

    system("echo", "-c", params[:command])

Of course not all dangerous shell commands are covered - so in general be careful passing any user-controlled input to a shell command.

([changes](https://github.com/presidentbeef/brakeman/pull/1396/))

### CookieSerialization Bug

[Phil Turnbull](https://github.com/philipturnbull) fixed an issue in `CheckCookieSerialization` where non-symbol cookie serialization options were handled poorly.

([changes](https://github.com/presidentbeef/brakeman/pull/1391))

### Brakeman::Differ Refactor

[Benoit Côté-Jodoin](https://github.com/Becojo) refactored `Brakeman::Differ` to compare warnings more efficiently and remove old fallback behavior.
All warnings are compared by fingerprint now when using `--compare`.

([changes](https://github.com/presidentbeef/brakeman/pull/1406))

### Version Comparisons

[Andrey Glushkov](https://github.com/aglushkov) updated the code for comparing library versions so it uses `Gem::Version` and handles "beta"/pre-release versions better.


([changes](https://github.com/presidentbeef/brakeman/pull/1405))

### %W Interpolation

String interpolation when using `%W` is no longer considered dangerous in shell commands where regular interpolation would be.

([changes](https://github.com/presidentbeef/brakeman/pull/1408))

### `form_for`

`form_for` is considered a safe method in XSS checks.

([changes](https://github.com/presidentbeef/brakeman/pull/1397/commits/a99cb25c6e76eb6240589f3a399e1245c0514257))

### String.new

`String.new << 'some string'` is now treated like `'' << 'some string'`.

([changes](https://github.com/presidentbeef/brakeman/pull/1397/commits/931bed18481679086a7102bc063ecf9b1d727d40))

### Checksums

The SHA256 sums for this release are:

    f43d949f1de9c0bb67b7bc7d41000ac70a1fb6c2250c5e7332015f0cc5ce36c5  brakeman-4.7.0.gem
    c02dbaa4ad0c7402ef99697c7b1916b7d9558dd5aa45e1a36efed117628498cc  brakeman-lib-4.7.0.gem
    3ab80a47bbfbb0f869bb1289292ed62b9643b5e0884a4a79e2c7e44218ce3b07  brakeman-min-4.7.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


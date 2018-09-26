---
layout: post
title: "Brakeman 3.3.2 Released"
date: 2016-06-10 08:49
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This is a bug fix release.

*Changes since 3.3.2*:

* Fix performance regression in global constant tracking 

Brakeman 3.3.0 introduced a new feature to track constant values across the application. This helped reduce false positives, for example when checking a value against a constant array of values. However, the lookup of constant values was very slow for moderate to large numbers of constants. In some test cases it added up to a minute of scan time. This has been resolved along with some changes to how dynamic constant names are handled.

Additionally, the `--faster` option will turn off global constant tracking entirely.

([changes](https://github.com/presidentbeef/brakeman/pull/891))

### SHAs

The SHA256 sums for this release are

    58bb2179de2bd479d32dc2d2018e40caf478916e283ea88089fe0bcb30a55e6c  brakeman-3.3.2.gem
    4f72ff02a163d78244554c4a26ea35e88d76dd6b60c3d21573db8518abcba6fc  brakeman-min-3.3.2.gem
    c0beeabe95aa693a5273bd48922028f48a190940b18c795813bd0f96068452b4  brakeman-lib-3.3.2.gem

### Reporting Issues

Thank you to the reporters of the performance issue in the 3.3.0 release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

For commercial support, please consider [Brakeman Pro](https://brakemanpro.com/).

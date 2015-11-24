---
layout: post
title: "Brakeman 3.1.3 Released"
date: 2015-11-23 23:23
comments: true
categories: 
---

This is a small release, except for one major new feature: Brakeman is now available as an engine on the new Code Climate platform!

_Changes since 3.1.2_:

* Add Code Climate output format ([Ashley Baldwin-Hunter](https://github.com/ABaldwinHunter)/[Devon Blandin](https://github.com/dblandin)/[John Pignata](https://github.com/presidentbeef/brakeman/pull/759)/[Michael Bernstein](https://github.com/mrb))
* Restore minimum Highline version ([Kevin Glowacz](https://github.com/kjg))
* Depend on safe\_yaml 1.0 or later ([#753](https://github.com/presidentbeef/brakeman/issues/752))
* Avoid outputting false for `user_input` in JSON
* Iteratively replace variables
* CallIndex improvements
* Improved tests for the Brakeman module ([Bethany Rentz](https://github.com/bethanyr)) 
* Make sure a `before_filter` with block is a call ([#763](https://github.com/presidentbeef/brakeman/issues/763))

### Code Climate

([changes](https://github.com/presidentbeef/brakeman/pull/758))

### Dependencies

Brakeman 3.1.0 relaxed the [Highline](https://github.com/JEG2/highline) dependency (to support Highline 1.7.x and up) and Brakeman 3.1.2 added a dependency on [safe_yaml](https://github.com/dtao/safe_yaml) without specifying a minimum version. Both of these changes resulted in some issues if combined with an application that depends on older versions of these libraries.

Highline and safe\_yaml now have minimum versions specified.

(changes [here](https://github.com/presidentbeef/brakeman/pull/762) and [here](https://github.com/presidentbeef/brakeman/pull/753))

### JSON Output

A refactoring caused some values of `user_input` in JSON reports to be `false` instead of `nil`. This has been corrected.

([changes](https://github.com/presidentbeef/brakeman/pull/756))

### More Variable Replacement

A long time ago, Brakeman used to do two passes for data flow analysis, just in case one substitution could be replaced with yet another value. The second pass was removed when it turned out not to be that helpful in reality. However, there are some cases where it is helpful. Now Brakeman will attempt substitutions if there are more matches, but with a hard limit of 5 replacements to avoid infinite loops. This will reduce false positives in some situations.

([changes](https://github.com/presidentbeef/brakeman/pull/757))

### CallIndex Improvements

Fixed a small bug where `params` was not a valid target when searching chained methods, as well as making it possible to search for chains beginning with a method call. Additionally, all the tests for CallIndex were broken and not testing anything.

([changes](https://github.com/presidentbeef/brakeman/pull/766))

### Improved Test Coverage

Thanks to [Bethany Rentz](https://github.com/bethanyr), [test coverage](https://codeclimate.com/github/presidentbeef/brakeman/coverage) was nudged up over 90%. Plenty of low-hanging fruit remains, [see this issue](https://github.com/presidentbeef/brakeman/issues/723) for suggestions of how to contribute!

([changes](https://github.com/presidentbeef/brakeman/pull/735))

### Brakeman Pro

Another small announcement: the first public release of [Brakeman Pro](http://brakemanscanner.org/brakeman_pro/) (the commercial version of Brakeman) is now available for purchase. If you are looking to financially support development of Brakeman, would like paid support, need a commercial license, or just want a slick GUI, consider checking out [Brakeman Pro](https://brakemanpro.com/).

For some clarification regarding the future of Brakeman and Brakeman Pro, please see [this email from earlier this year](http://librelist.com/browser//brakeman/2015/2/24/future-of-brakeman/).

### SHAs

The SHA256 sums for this release are


### Reporting Issues

Thank you to everyone who reported bugs and contributed improvements in this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter, joining the [mailing list](http://brakemanscanner.org/contact/), or hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman).


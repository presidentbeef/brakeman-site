---
layout: post
title: "Brakeman 3.1.3 Released"
date: 2015-12-02 09:23
comments: true
---

This is a small bug fix release, except for one major new feature: [Brakeman is now available as an engine on the new Code Climate platform](https://codeclimate.com/changelog/5653c9b67f7feb0048003051)!

_Changes since 3.1.2_:

* Add Code Climate output format ([Ashley Baldwin-Hunter](https://github.com/ABaldwinHunter) / [Devon Blandin](https://github.com/dblandin) / [John Pignata](https://github.com/presidentbeef/brakeman/pull/759) / [Michael Bernstein](https://github.com/mrb))
* Restore minimum Highline version ([Kevin Glowacz](https://github.com/kjg))
* Depend on safe\_yaml 1.0 or later ([#753](https://github.com/presidentbeef/brakeman/issues/752))
* Check for session secret in secrets.yml ([#760](https://github.com/presidentbeef/brakeman/issues/760))
* Avoid warning on `without_protection: true` with hash literal ([#769](https://github.com/presidentbeef/brakeman/issues/769))
* Respect `exit_on_warn` in config file ([#771](https://github.com/presidentbeef/brakeman/pull/771))
* Avoid outputting false for `user_input` in JSON
* Iteratively replace variables
* CallIndex improvements
* Improved tests for the Brakeman module ([Bethany Rentz](https://github.com/bethanyr)) 
* Make sure a `before_filter` with block is a call ([#763](https://github.com/presidentbeef/brakeman/issues/763))

### Code Climate Platform

Thanks to the folks at [Code Climate](https://codeclimate.com/), this release adds the ability to run Brakeman as an analysis engine on [Code Climate’s platform](https://codeclimate.com/changelog/5653c9b67f7feb0048003051). You can now run Brakeman as part of Code Climate’s hosted analysis, or on your command line with their open source CLI. Brakeman can be integrated with results from your other favorite static analysis tools, giving you a unified view of issues in your code.

([main changes](https://github.com/presidentbeef/brakeman/pull/758))

### Dependencies

Brakeman 3.1.0 relaxed the [Highline](https://github.com/JEG2/highline) dependency (to support Highline 1.7.x and up) and Brakeman 3.1.2 added a dependency on [safe_yaml](https://github.com/dtao/safe_yaml) without specifying a minimum version. Both of these changes resulted in some issues if combined with an application that depends on older versions of these libraries.

Highline and safe\_yaml now have minimum versions specified.

(changes [here](https://github.com/presidentbeef/brakeman/pull/762) and [here](https://github.com/presidentbeef/brakeman/pull/753))

### More Secrets

Production session secrets stored in `config/secrets.yml` will now raise a warning.

([changes](https://github.com/presidentbeef/brakeman/pull/776)

### Mass Assignment False Positive

Previously, Brakeman would warn on any mass assignment using `without_protection: true`. [This blog post](https://carouselapps.com/2015/11/24/using-brakeman/) noted Brakeman would even warn if the values for mass assignment were a hash literal. This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/773))

### Harcode Mode in Config

Brakeman now supports turning on "hardcore mode" (setting `:exit_on_warn: true`) in a config file. This causes Brakeman return a non-zero exit code if any warnings are found.

([changes](https://github.com/presidentbeef/brakeman/pull/774))

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

For some clarification regarding the future of Brakeman and Brakeman Pro, please see [this email from earlier in the year](http://librelist.com/browser//brakeman/2015/2/24/future-of-brakeman/).

### SHAs

The SHA256 sums for this release are

    57b0edcc289eb74359d2042a38ea519f96f606c89dc879e5fb53971d3d656707  brakeman-3.1.3.gem
    85473af3a55c440959ea91f94fe14177ac58aa35b44fbb007c93cd742803eae6  brakeman-min-3.1.3.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed improvements in this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter, joining the [mailing list](http://brakemanscanner.org/contact/), or hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman).


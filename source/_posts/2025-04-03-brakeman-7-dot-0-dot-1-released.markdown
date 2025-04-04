---
layout: post
title: "Brakeman 7.0.1 Released"
date: 2025-04-03 17:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

_Changes since 7.0.0:_

* Avoid warning on evaluation of plain strings ([#1919](https://github.com/presidentbeef/brakeman/issues/1919))
* Enable use of custom/alternative Gemfiles ([#1840](https://github.com/presidentbeef/brakeman/issues/1840), [#1907](https://github.com/presidentbeef/brakeman/issues/1907))
* Fix error on directory with `rb` extension ([viralpraxis](https://github.com/viralpraxis))
* Support `terminal-table` 4.0 ([Chedli Bourguiba](https://github.com/viralpraxis))
* Better support Prism 1.4.0 ([#1927](https://github.com/presidentbeef/brakeman/issues/1927))
* Only output timing for each file when using `--debug`

### Fewer Code Evaluation Warnings

Brakeman will warn on fewer cases of code evaluation of dynamic strings.

([changes](https://github.com/presidentbeef/brakeman/pull/1920))

### Custom Gemfile

Which `Gemfile` to scan can now be configured with `--gemfile` or setting the `BUNDLE_GEMFILE` option.

([changes](https://github.com/presidentbeef/brakeman/pull/1912))

### Errors Matching Directory Names 

Thanks to [viralpraxis](https://github.com/viralpraxis) for fixing an issue where directory names ending in `.rb` were treated like Ruby files.

([changes](https://github.com/presidentbeef/brakeman/pull/1911))

### Support for Terminal Table 4.0

Thanks to [Chedli Bourguiba](https://github.com/chaadow) for helping bump the `terminal-table` dependency to allow use of the latest version.

([changes](https://github.com/presidentbeef/brakeman/pull/1917))

### Frozen Strings in Prism

This release fixes some compatibility with frozen strings in Prism 1.4.0.

These are a little hard to track down, so please report any errors that have not been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/1928))

### Less Noisy Timing

Use of `--timing` is now a little less noisy unless `--debug` is also set.

Previously, processing time for each individual file was shown. Now the default is to only show processing time for each step in the scan.

([changes](https://github.com/presidentbeef/brakeman/pull/1908))

### Checksums

The SHA256 sums for this release are:

    ec751d439820ed9d04d4ed00ff4fb21ac91689fcbb6cc564b786a4061c8f720d  brakeman-7.0.1.gem
    94c3b2801ce8c35db9354b778feb06dcfafc8273c3f09d398771912de793aa52  brakeman-lib-7.0.1.gem
    a3a9b3c2ecd5f34abbc689f14ad3abd7f4380a7ffcb21c2310f7a74efc543805  brakeman-min-7.0.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

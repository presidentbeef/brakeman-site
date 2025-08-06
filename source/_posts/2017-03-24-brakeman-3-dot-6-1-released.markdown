---
layout: blog
title: Brakeman 3.6.1 Released
date: 2017-03-24 13:15
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 3.6.0
  changes:
  - "* Fix error when using `--compare` ([Sean Gransee](https://github.com/seangransee))"
checksums:
- hash: 3c10b2a9fd8b7b3baab956e6fcc2c7780768f1905433297e8dd940591f1bbb3b
  file: brakeman-3.6.1.gem
- hash: 98f6bd7531e0e3fbe273b9d185446bd28602176a392d5df8f9c52c36460afdaa
  file: brakeman-lib-3.6.1.gem
- hash: 44342c843867fce585f6fef09cd093a0544510adfeec15217efe44c6120e3192
  file: brakeman-min-3.6.1.gem
---


This is a small bug fix release to fix an issue when using `--compare`.


## Error With Compare

Although comparison scans using `--compare` would complete successfully, an exception was being thrown afterwards.

Thanks to [Anthony Lamorte](https://github.com/anthlam) for reporting and [Sean Gransee](https://github.com/seangransee) for the fix!

([changes](https://github.com/presidentbeef/brakeman/pull/1024))


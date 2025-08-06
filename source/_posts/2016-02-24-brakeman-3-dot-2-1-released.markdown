---
layout: blog
title: Brakeman 3.2.1 Released
date: 2016-02-24 21:36
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 3.2.0
  changes:
  - Remove `multi_json` dependency from `bin/brakeman`
---



As pointed out by [Benjamin Fleischer](https://github.com/bf4), there was a lingering use of `multi_json` in `bin/brakeman`. This only caused a problem when using the `--compare` option.

([changes](https://github.com/presidentbeef/brakeman/pull/831))

## SHAs

The SHA256 sums for this release are

    4a7e7a6e9ad9fed22f727fb8d471de145f55d97465b4dfb4935e3e8379667425  brakeman-min-3.2.1.gem
    901202b04b1cae0a781b5a6bae2db3eecd35e9f0a044fbfaa31cac63ab636449  brakeman-3.2.1.gem

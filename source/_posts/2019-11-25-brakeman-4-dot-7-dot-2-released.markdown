---
layout: blog
title: Brakeman 4.7.2 Released
date: 2019-11-25 14:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.7.1
  changes:
  - Add `request.params` as query parameters ([#1398](https://github.com/presidentbeef/brakeman/issues/1398))
  - Handle more `permit!` cases ([#1426](https://github.com/presidentbeef/brakeman/issues/1426))
  - Remove version guard for `named_scope` vs. `scope`
  - Find SQL injection in `String#strip_heredoc` target ([#1433](https://github.com/presidentbeef/brakeman/issues/1433))
  - Ensure file name is set when processing models
  - Bundle `ruby_parser` version 3.14.1 ([#1429](https://github.com/presidentbeef/brakeman/issues/1429))
checksums:
- hash: 339d6f3707a2c0a32003536a231255b839a0b87bd6a7ebef3c82aedd1bdd3ac8
  file: brakeman-4.7.2.gem
- hash: 39ce3a5fe248dee8c78fe671441d2abbfec66cec923ee9f56c62018229d3c9b0
  file: brakeman-lib-4.7.2.gem
- hash: efa07aa8476ef5553c91734093349a3ed55e2ef05b469d3dcecfdaabede37296
  file: brakeman-min-4.7.2.gem
---


Some minor fixes for a minor release.


## More Query Parameters 

`request.params` has been added as a query parameters method.

([changes](https://github.com/presidentbeef/brakeman/pull/1423))

## More `permit!`

More cases of `permit!` will be identified, particularly when it is the target of a method call.

([changes](https://github.com/presidentbeef/brakeman/pull/1427))

## More Scopes

Both `named_scope` and `scope` will be handled regardless of detected Rails version.

([changes](https://github.com/presidentbeef/brakeman/pull/1435))

## SQL Injection with `strip_heredoc`

`strip_heredoc` is now treated as returning a string.
This fixes false positives if the target is a plain string and fixes false negatives if the target has interpolation.

([changes](https://github.com/presidentbeef/brakeman/pull/1434))

## Model File Names

In some cases, warnings were missing file names because the file name was not being passed to the model processor.

The file name will now be passed along, and there is a new test in the test suite for file names on warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/1431))



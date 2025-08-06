---
layout: blog
title: Brakeman 4.2.0 Released
date: 2018-02-21 13:34
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.1.1
  changes:
  - Handle ERb use of `String#<<` method for Ruby 2.5 ([Pocke](https://github.com/pocke))
  - Exclude template folders in `lib/` ([kru0096](https://github.com/Kani999))
  - Warn about SQL injection with `not`
  - Avoid warning about symbol DoS on `Model#attributes` ([#1096](https://github.com/presidentbeef/brakeman/issues/1096))
  - Avoid warning about open redirects with model methods ending with `_path`([#1117](https://github.com/presidentbeef/brakeman/issues/1117))
  - Avoid warning about command injection with `Shellwords.escape` ([#1159](https://github.com/presidentbeef/brakeman/issues/1159))
  - Use ivars from `initialize` in libraries
  - Fix multiple assignment of globals ([#1155](https://github.com/presidentbeef/brakeman/issues/1155))
  - "`Sexp#body=` can accept `:rlist` from `Sexp#body_list`"
  - Update RubyParser to 3.11.0
checksums:
- hash: c6ad3861920075ccf553343815fcce07aa09d015bc8529c6e4d8a865674530f7
  file: brakeman-4.2.0.gem
- hash: 94a97496761ddd27974867bde3235cab303761dadec4bd6a8d22260a72aaaa38
  file: brakeman-lib-4.2.0.gem
- hash: a071eb6d6e866df0338bcb9c8dd56f5b0d66c68212eb604f551ac8aa196d6923
  file: brakeman-min-4.2.0.gem
---


First release of 2018!


## Update ERb Handling for Ruby 2.5.0

The way ERb templates are compiled changed in Ruby 2.5.0 to use `String#<<`, so Brakeman has been changed to accomodate.

Please note ERb also changed such that `<% #` is not supported in Ruby 2.5.0. It will be fixed in the next Ruby release, but the correct syntax is `<%#`.

([changes](https://github.com/presidentbeef/brakeman/pull/1149))

## Exclude Template Folders

Files in `lib/**/templates` will be ignored, since they are generally ERb files, not actually Ruby.

([changes](https://github.com/presidentbeef/brakeman/pull/1143))

## SQL Injection with `not`

In ActiveRecord, `not` takes the same arguments as `where`, making it just as vulnerable to SQL injection.

Thank you to [Jobert Abma](https://twitter.com/jobertabma) for reporting this.

([changes](https://github.com/presidentbeef/brakeman/pull/1152))

## Symbol DoS False Positive

Brakeman will no longer warn about `Model#attributes.symbolize_keys`.

([changes](https://github.com/presidentbeef/brakeman/pull/1165))

## Open Redirect False Positive

Brakeman will no longer warn about open redirects with `Model#something_ending_in_path`.

([changes](https://github.com/presidentbeef/brakeman/pull/1164))

## Shellwords Escaping

Brakeman will no longer warn about command injection when `Shellwords.escape` and friends are used.

Please note that user input in shell commands is rarely a good idea, even if escaped, since they can change the behavior of the program in unexpected ways. Many Linux tools have options that allow arbitrary code execution.

([changes](https://github.com/presidentbeef/brakeman/pull/1162))

## Use Initialized Environment in Libraries

When processing libraries, instance variables set in `initialize` will be used in subsequent methods.

([changes](https://github.com/presidentbeef/brakeman/pull/1161))

## Update RubyParser

This release includes updated versions of RubyParser and friends. This may cause some warning fingerprints to change if they include a call to `self[...]`.

([changes](https://github.com/presidentbeef/brakeman/pull/1160))


---
layout: blog
title: "Brakeman 7.1.2 Released"
subtitle: "Ruby 4.0 compatibility and fewer false positives"
date: 2025-12-25
version: "7.1.2"
changelog:
  since: "7.1.1"
  changes:
    - "Update `ruby_parser` to remove max version restriction ([Chedli Bourguiba](https://github.com/chaadow))"
    - "Increase minimum Ruby version to 3.2.0"
    - "Reduce SQL injection false positives from `count` (and other) calls ([#1936](https://github.com/presidentbeef/brakeman/pull/1936))"
    - "Remove more XSS false positives related to Haml attribute builder"
    - "Update Minitest version to 6.0"
checksums:
  - hash: "6b04927710a2e7d13a72248b5d404c633188e02417f28f3d853e4b6370d26dce"
    file: "brakeman-7.1.2.gem"
  - hash: "814c83ec5262f882dc5644c2b0c448d2a7e9a3f3c4fe3afefc36e8c7ff63bfce"
    file: "brakeman-lib-7.1.2.gem"
  - hash: "4eed82aca0156103f7205e9d8189daad9d18f01edf3eab17eed88835bd1a4eba"
    file: "brakeman-min-7.1.2.gem"
permalink: /blog/:year/:month/:day/:title
---

## Dependency Updates

Chedli Bourguiba updated RubyParser to 3.22 which removes a Ruby version cap so it can be used with Ruby 4.0.

([changes](https://github.com/presidentbeef/brakeman/pull/1987))

Minitest (dev-only dependency) updated to 6.0. Since Minitest dropped support for Ruby 3.1, this is a good time for Brakeman to do so, too.
Minimum Ruby version to run Brakeman is now 3.2.0, although note Brakeman supports parsing of much older versions of Ruby. The version of Ruby used to run Brakeman does not need to match the version used to run the Rails application being scanned.

([changes](https://github.com/presidentbeef/brakeman/pull/1985))

## SQL Injection False Positives

Fixes in the previous release caused a high number of false positives related to `count` calls that were not actually ActiveRecord methods.

This release should address most of these false positives unless the application is using an ancient version of Rails.

([changes](https://github.com/presidentbeef/brakeman/pull/1980))

## More Haml Fixes

More methods used by `Haml::AttributeBuilder` are ignored, as long as the first argument is `true` (which indicates the output will be HTML-escaped).

([changes](https://github.com/presidentbeef/brakeman/pull/1988))

## Reporting Issues

Additional thanks to [James Thompson](https://github.com/thompson-tomo) and [Sam Partington](https://github.com/sampart) for fixing the list of supoprted report types!

As a reminder, supoprted formats are:

- `text` - Default
- `html`
- `json`
- `junit` - Specifically compatible with CircleCI
- `markdown`
- `csv`
- `github`
- `sarif`
- `sonar`
- `tabs` - Deprecated, avoid
- `codeclimate` - Deprecated

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

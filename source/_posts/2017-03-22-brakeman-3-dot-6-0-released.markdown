---
layout: post
title: "Brakeman 3.6.0 Released"
date: 2017-03-22 10:30
comments: true
categories: 
---

*Changes since 3.5.0:*

* Branch inside of `case` expressions ([#944](https://github.com/presidentbeef/brakeman/issues/944), [#972](https://github.com/presidentbeef/brakeman/issues/972), [#1002](https://github.com/presidentbeef/brakeman/issues/1002)) 
* Check targetless SQL calls outside of known models
* Fix issue with nested interpolation inside SQL strings ([#1008](https://github.com/presidentbeef/brakeman/issues/1008))
* Add `--exit-on-error` ([Michael Grosser](https://github.com/grosser))
* Only report CVE-2015-3227 when exact version is known ([#933](https://github.com/presidentbeef/brakeman/issues/993), [#995](https://github.com/presidentbeef/brakeman/issues/995))
* Print command line option errors without modification ([#1010](https://github.com/presidentbeef/brakeman/issues/1010))
* Ignore GraphQL tags inside ERB templates
* Avoid recursive `Concern`s

### Case Expressions

At long last, Brakeman will now treat `case` expressions similarly to `if`s. This includes tracking variable assignments inside of `when` clauses and better handling `case` expressions as values.

Note that at this time Brakeman does not handle nested `case` expressions.

([changes](https://github.com/presidentbeef/brakeman/pull/1018))

### Targetless SQL Calls

Brakeman 3.5.0 broadened the check for SQL injection to calls that *may* not be on models (because models are often defined outside the application). However, calls with no target were still checking to see if they were called inside of model classes. This led to missing some SQL injection vulnerabilities.

([changes](https://github.com/presidentbeef/brakeman/pull/994))

### Nested SQL Interpolation

Some cases of nested string interpolation in SQL calls were generating false positives. This should be fixed now.

([changes](https://github.com/presidentbeef/brakeman/pull/1009))

### Exit on Errors

[Michael Grosser](https://github.com/grosser) added the `--exit-on-error` option to cause Brakeman to exit with a non-zero exit code if any errors are encountered. Normally Brakeman attempts to always generate a report regardless of any errors during the scan.

([changes](https://github.com/presidentbeef/brakeman/pull/991))

### Spurious CVE Warning

Brakeman was reporting CVE-2015-3227 on any application using an unknown Rails version.

([changes](https://github.com/presidentbeef/brakeman/pull/996))

### Option Errors

In an attempt to make command line option errors prettier, Brakeman was inadvertently messing up the error messages. It will no longer do so.

([changes](https://github.com/presidentbeef/brakeman/pull/1011))

### GraphQL in ERB

Brakeman will now ignore `<%graphql` tags in ERB templates.

([changes](https://github.com/presidentbeef/brakeman/pull/997))

### Recursive Concerns

Concerns that `include` themselves will no longer cause infinite loops.

([changes](https://github.com/presidentbeef/brakeman/pull/1019))

### Checksums

The SHA256 sums for this release are:

    c9bcc82a14359fe5f010551b1256eb1cea6848115f3429c7db74a386d6b0cf8c  brakeman-3.6.0.gem
    4793a407f79970a284474db3235d355f9927e987b71e33f1ce99fac3f3c249aa  brakeman-min-3.6.0.gem
    5c0a7aab7fc14d069d9dc208b653e10f71c355cb959fd144d6e8f7430c88a8e7  brakeman-lib-3.6.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development, check out [Brakeman Pro](https://brakemanpro.com/).

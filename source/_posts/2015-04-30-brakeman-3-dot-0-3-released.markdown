---
layout: post
title: "Brakeman 3.0.3 Released"
date: 2015-04-30 09:50
comments: true
categories: 
---

This is mostly a bug fix release, but does introduce a new warning code for when `protect_from_forgery` is not set to raise exceptions in Rails 4.

*Changes since 3.0.2*:

* Warn about `protect_from_forgery` without exceptions ([Neil Matatall](https://github.com/oreoshake))
* Add Rake task to exit with error code on warnings ([masarakki](https://github.com/masarakki))
* Ignore `quoted_table_name` in SQL ([Gabriel Sobhrinho](https://github.com/sobrinho))
* Ignore more Arel methods in SQL ([#604](https://github.com/presidentbeef/brakeman/issues/604))
* Warn about RCE and file access with `open`
* Handle `Array#include?` guard conditionals ([#604](https://github.com/presidentbeef/brakeman/issues/604))
* Handle lambdas as filters
* Do not ignore targets of `to_s` in SQL ([#638](https://github.com/presidentbeef/brakeman/issues/638))

### New CSRF Warning

[Neil Matatall](https://github.com/oreoshake) has added a warning for Rails 4 applications that do not pass the `with: :exception` option to `protect_from_forgery`. The default behavior of clearing out the session (but still processing the request) has lead to vulnerabilities in some applications. GitHub [recently awarded a bug bounty](https://bounty.github.com/researchers/LukasReschke.html) for a vulnerability caused by this behavior.

([changes](https://github.com/presidentbeef/brakeman/pull/648))

### Additional Rake Task

[Masarakki](https://github.com/masarakki) added a Rake task that will exit with an error code if any warnings are found (like `brakeman -z`). The task can be run with `rake brakeman:check`.

However, please note the use of Rake tasks to run Brakeman is discouraged, since it loads the entire Rails application which is unnecessary and may cause conflicts with Brakeman dependencies.

([changes](https://github.com/presidentbeef/brakeman/pull/637))

### Reduce SQL Injection False Positives

A patch from [Gabriel Sobhrinho](https://github.com/sobrinho) removes warnings about `quoted_table_name` in SQL queries.

([changes](https://github.com/presidentbeef/brakeman/pull/647))

An additional change was made to ignore more Arel methods nested inside of other queries. This should reduce many of the false positives seen with combining Arel and ActiveRecord queries.

([changes](https://github.com/presidentbeef/brakeman/pull/653))

### Remote Code Execution in open()

As noted in [Egor Homakov's blog post](http://sakurity.com/blog/2015/02/28/openuri.html), `open` can actually be used to spawn new processes by starting the argument with a pipe `|`. Brakeman will now warn about remote code execution via `open`.

([changes](https://github.com/presidentbeef/brakeman/pull/643))

### Simple Guard Conditions

Brakeman should now recognize guard conditions that look exactly like this:

    if [1, 2, "a", "b"].include? x
      do_something_dangerous_with x
    end

This may resolve some false positives. If you have code similar to this, please consider [opening an issue](https://github.com/presidentbeef/brakeman/issues) and perhaps it can be handled similarly.

([changes](https://github.com/presidentbeef/brakeman/pull/640))

### Lambda Filters

Filters that use lambdas instead of blocks should now be handled correctly.

([changes](https://github.com/presidentbeef/brakeman/pull/649))

### Handle to_s in SQL

Values with `to_s` called on them were being ignored when checking for SQL injection. This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/639))

### SHAs

The SHA1 sums for this release are

    170c3dd6925373b7da2e27fd1decf2957b35dc43  brakeman-3.0.3.gem
    f126e305404a61e99f9ddb848996d87325d1485a  brakeman-min-3.0.3.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/).

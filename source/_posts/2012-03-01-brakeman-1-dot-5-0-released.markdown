---
layout: blog
title: Brakeman 1.5.0 Released
date: 2012-03-01 20:23
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.4.0
  changes:
  - " * Add version check for SafeBuffer vulnerability"
  - " * Add check for select vulnerability in Rails 3"
  - " * select() is no longer considered safe in Rails 2"
  - " * Add check for skipping CSRF protection with a blacklist"
  - " * Add JSON report format"
  - " * Model#id should not be considered XSS"
  - " * Standardize methods to check for SQL injection"
  - " * Fix Rails 2 route parsing issue with nested routes"
---


A release was forced today because two new Rails vulnerabilities were reported (the first since November):

 * [Manual options are not escaped in select()](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/9da0c515a6c4664)
 * [Some operations on SafeBuffer mistakenly return strings marked as html_safe](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/edd28f1e3d04e913)

This release includes checks for these two vulnerabilities.

There is also a new check for skipping CSRF token verification, and some other changes which may result in fewer or more vulnerabilities being reported.


## Check for SafeBuffer Vulnerability

A new vulnerability was reported that affects strings which are marked as `html_safe` and then modified in some way. For some operations, the new, modified string will still be marked as `html_safe`. Full details [here](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/edd28f1e3d04e913).

For this vulnerability, Brakeman only does a version check and reports if an application is used a vulnerable version of Rails. It only reports on Rails 3 applications, since Rails 3 introduced the concept of SafeBuffers.

## Check for select Helper Vulnerability

Another vulnerability was reported today in the `select` form helper. Option tags built by hand (interpolating values into `<option></option>`) will not be escaped by `select`. Full details [here](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/9da0c515a6c4664).

For Rails 3 applications, Brakeman checks for uses of `select` which have user input in the `options` argument. This check may be refined in the future.

For Rails 2, Brakeman no longer considers `select` a safe method when checking for cross site scripting.

## Check for CSRF Filter Skipping

When cross site request forgery protection is enabled, a `before_filter` is added called `verify_authenticity_token`. This filter checks that actions called responding to a `POST` have a correct authenticity token from the client. Since this is a regular `before_filter`, it can be skipped using `skip_before_filter`.

If `skip_before_filter` is called using an `:except` option, then the default for the controller becomes NOT checking for an authenticity token:

    skip_before_filter :verify_authenticity_token, :except => [:create, :delete]

It is recommended to use `:only` if skipping this filter is actually necessary. This way, any new actions added later will automatically fall under the CSRF protection.

This check may be extended in the future to other important filters.

## JSON Report Format

While the code for outputting JSON was in the 1.4.0 release, it was not actually added as a proper output format! This has been rectified.

`-f json` or `-o report.json` will now produce JSON reports.

The information contained in these reports may change in the future, although that should only be adding more information.

## SQL Methods

The code for finding SQL methods to check for SQL injection was a little messed up. Depending on how the method was called, different sets of methods were considered dangerous.

This has been changed for better consistency and coverage. This means reports may include new SQL injections, so keep an eye out.

## Rails 2 Route Parsing Fix

There was a bug in the code which determined if a method was being called on `map`, which caused Brakeman to think strange methods were route definitions (for example, `require`). This has been fixed.

## Report Problems!

Always [report problems](https://github.com/presidentbeef/brakeman/issues) encountered when running Brakeman.

Don't forget to join the [mailing list](http://librelist.com/browser/brakeman/) and/or follow [@Brakeman](https://twitter.com/brakeman) on Twitter.

---
layout: post
title: "Brakeman 1.6.2 Released"
date: 2012-06-12 17:07
comments: true
categories: 
---

Besides checks for the latest CVEs, this release includes a slightly improved redirect check, noiser output with `--compare`, and better handling of `before_filter`.

_Changes since 1.6.1_:

 * Add checks for CVE-2012-2660, CVE-2012-2661, CVE-2012-2694, CVE-2012-2695 (Dave Worth)
 * Avoid warning when redirecting to a model instance
 * Raise confidence level for model attributes in redirects
 * Add `request.parameters` as a parameters hash
 * Return non-zero exit code when missing dependencies
 * Fix `before_filter :except` logic
 * Only accept symbol literals as before_filter names
 * Cache before_filter lookups
 * Turn off quiet mode by default for `--compare`

### Latest CVEs

A number of Rails vulnerabilities were announced recently, although there are really only two issues.

One issue is that query parameters like `?name[]` and `?name[]=1&name[]` get converted to `{"name" => [nil]}` and `{"name" => ["1", nil]}`. This, in turn, causes ActiveRecord to produce SQL queries with either `IS NULL` or `IN ('1', NULL)`. This is probably unexpected behavior.

The other issue is that query parameters like `?name[users.id]=1` or `?name[users][id]=1` get converted to `{"name" => { "users.id" => 1 }}` or `{"name" => { "users" => { "id" => 1 }}}`. ActiveRecord interprets `"users.id"` and `"users" => { "id" ...}` as `"users"."id"` in the WHERE clause, allowing an attacker to control the table/columns being queried. 

Updated versions for Rails 3.x have been released.

For Rails 2.3, I believe [these changes](https://github.com/presidentbeef/rails/pull/1/files) will fix the first issue, and there is another [patch available](https://rubyonrails-security.googlegroups.com/attach/aee3413fb038bf56/2-3-sql-injection.patch?view=1&part=3) for the second issue.

Older versions of Rails 2.x may be vulnerable to the "NULL" issue, but not to the nested hashes problem.

### Unprotected Redirect Check

There have been some minor changes to `CheckRedirect`. In most cases, it should no longer warn when redirecting to a model instance. If there are still false positives with this scenario, please report them.

The other change is that redirects to model attributes will now be marked as high confidence, instead of weak.

### Exit Code on Missing Dependencies

Brakeman catches errors from missing dependencies in order to show a nicer error message. Unfortunately, it was also returning `0` on exit. This is undesirable behavior when chaining commands together.

This has been changed to return a non-zero exit code.

### Before Filter Changes

There were some isues with how `before_filter` was being handled. The logic when using `:except` was broken, causing Brakeman to treat it like `:only`.

The other issue caused Brakeman to interpret arguments such as method calls as method names. For example, `before_filter blah` would be treated like `before_filter :blah`.

While dealing with this, caching of filter lookups was also added for a minor performance improvement.

### Noisier `--compare`

Using the `--compare` option now shows the same output as a regular scan. If you are piping the output of `--compare` to a file or elsewhere, you may wish to use the `--quiet` option.

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter. 

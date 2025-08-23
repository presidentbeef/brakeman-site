---
layout: blog
title: Brakeman 1.8.3 Released
date: 2012-11-13 09:20
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.8.2
  changes:
  - " * Use `multi_json` gem for better harmony ([#164](https://github.com/presidentbeef/brakeman/issues/164))"
  - " * Performance improvement for call indexing"
  - " * Fix issue with processing HAML files ([#168](https://github.com/presidentbeef/brakeman/issues/168))"
  - " * Handle pre-release versions when processing `Gemfile.lock` ([#174](https://github.com/presidentbeef/brakeman/issues/174))"
  - " * Only check first argument of `redirect_to` ([#98](https://github.com/presidentbeef/brakeman/issues/98))"
  - " * Fix false positives from `Model.arel_table` accesses"
  - " * Fix false positives on redirects to models decorated with Draper gem ([#172](https://github.com/presidentbeef/brakeman/issues/172))"
  - " * Fix false positive on redirect to model association ([#111](https://github.com/presidentbeef/brakeman/issues/111))"
  - " * Fix false positive on `YAML.load` ([#142](https://github.com/presidentbeef/brakeman/issues/142))"
  - " * Fix false positive XSS on any `to_i` output"
  - " * Fix error on Rails 2 named routes with no args"
  - " * Fix error in rescan of mixins with symbols in method name"
  - " * Do not rescan non-Ruby files in config/"
---


This is primarily a false positive reduction release. One major change is the change in dependency from the `json_pure` gem to `multi_json`.


## Change to MultiJSON

Brakeman now depends on the [multijson](http://rdoc.info/github/intridea/multi_json) gem instead of `json_pure`. This should make it easier for people who include Brakeman as a dependency.

([changes](https://github.com/presidentbeef/brakeman/pull/166))

## Faster Call Indexing

Dumb code in the `CallIndex` was causing call indexing to be slow on some large applications. This should now be faster and require less memory!

([changes](https://github.com/presidentbeef/brakeman/pull/180))

## Fix HAML Processing

Some HAML files were causing Brakeman's alias processing to slow to a crawl. This was due to the template code (sometimes) directly appending to the output variable via `<<`. Since Brakeman attempts to treat targets of `<<` as arrays, Brakeman was generating large data structures each time `<<` was encountered.

([changes](https://github.com/presidentbeef/brakeman/pull/170)]

## Handle Pre-release Versions

When a `Gemfile.lock` file is present in a Rails application, Brakeman uses it to determine the version of Rails in use. Previous versions did not accept pre-release version numbers (like `3.1.2.rc1`), leading to version inappropriate warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/176))

## Redirect False Positives

Several false positives related to redirects have been fixed, and the scope of the redirect check is somewhat reduced.

Calls beginning with `Model.arel_table` should no longer be treated as user input (in any context).

Model instances returned by the `decorate` method in the [Draper](https://github.com/drapergem/draper) gem are considered safe.

Redirects to model associations (e.g, `belongs_to :account`) are considered safe.

Redirects to method calls with safe values should no longer warn. For example:

    redirect_to blah(User.first) #No warning

Additionally, only the first argument of `redirect_to` will be checked for user input.

([changes](https://github.com/presidentbeef/brakeman/pull/177))

## YAML False Positive

File access warnings for YAML calls have been reduced to only those calls which actually access files.

([changes](https://github.com/presidentbeef/brakeman/pull/178))

## Integer Output False Positives

Calls to `to_i` should not trigger XSS warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/179))

## Errors on Named Routes

Rails 2 named routes with no arguments were causing errors, which have now been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/181))

## Future Work

Now that RubyParser 3.x is officially released, work is underway to use the new version. This will increase Ruby 1.9 syntax compatibility and remove the need to parse applications with the same Ruby version as the application uses. Additionally, it will allow us to get rid of the vendored version of RubyParser that Brakeman uses for Ruby 1.9. Unfortunately, RubyParser 3.x introduces a lot of incompatibilities and upgrading requires a significant amount of effort.

Another exciting feature in development is limited interprocedural analysis. Brakeman will be able to handle simple things like calls to helper methods in controllers which set instance variables or return user input. This should help with the "obvious" vulnerabilities that Brakeman often misses.

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.


---
layout: post
title: "Brakeman 1.8.1 Released"
date: 2012-09-24 12:09
comments: true
categories: 
---

Bug fixes!

_Changes since 1.8.0_:

 * Recover from errors in output formatting ([#148](https://github.com/presidentbeef/brakeman/pull/148))
 * Fix false positive in `redirect_to` (Neil Matatall) ([#143](https://github.com/presidentbeef/brakeman/issues/143))
 * Fix problems with removal of `Sexp#method_missing` ([#150](https://github.com/presidentbeef/brakeman/pull/150))
 * Fix array indexing in alias processing ([#145](https://github.com/presidentbeef/brakeman/pull/145))
 * Fix old `mail_to` vulnerability check ([#147](https://github.com/presidentbeef/brakeman/pull/147))
 * Fix rescans when only controller action changes ([#141](https://github.com/presidentbeef/brakeman/pull/141))
 * Allow comparison of versions with unequal lengths ([#144](https://github.com/presidentbeef/brakeman/pull/144))
 * Handle super calls with blocks ([#146](https://github.com/presidentbeef/brakeman/pull/146))
 * Remove malformed Sexps from HAML processing  ([#149](https://github.com/presidentbeef/brakeman/pull/149))
 * Respect `-q` flag for "Rails 3 detected" message


### Fix Crashes when Generating Report

Some scans were causing Brakeman to crash while generating reports with an error like:

    lib/brakeman/warning.rb:78:in `format_code': undefined method `gsub' for nil:NilClass (NoMethodError)

This was due to a combination of the removal of `method_missing` behavior from `Sexp` and the `OutputProcessor` not handling errors well.

The problem should be fixed now, but please report an issue if "[Format Error]" shows up in reports.

### False Positive in Redirect Check

Neil Matatall fixed [an issue](https://github.com/presidentbeef/brakeman/issues/143) with a false positive when redirecting to an array.

When `redirect_to` is given an array, Rails eventually falls through to `polymorphic_path`, which will only return a path, not a full URL. Brakeman only checks for redirects that can redirect to a different host, so this is considered safe.

### Sexp and `method_missing`

The original `Sexp` code from RubyParser uses `method_missing` to find and optionally delete nodes. This functionality is not used very often (never in Brakeman) but has covered up bugs that would otherwise been found. Therefore, `Sexp#method_missing` has been removed in Brakeman. However, it turns out that [Ruby2Ruby](https://github.com/seattlerb/ruby2ruby) uses it in a couple places. Brakeman uses Ruby2Ruby to covert s-expressions back to readable Ruby code, particularly when generating reports. This lead to some crashes.

### Fix Array Indexing

Brakeman can handle pulling values out of simple arrays. Or it should be able to, but it keeps breaking. Should be fixed now!

### Fix `mail_to` Check

There is a Brakeman check for an [old vulnerability](https://groups.google.com/d/topic/rubyonrails-security/8CpI7egxX4E/discussion) in `mail_to`. However, it turns out this check has been broken for a while. But now it is fixed! And there are regression tests.

### Fix Rescans on Controller Changes

There were some crashes when rescanning was triggered by a controller change.

### HAML Processing

Some very old code for HAML processing was generating malformed s-expressions, which then had to be handled specially in the output formatter. It turns out these nodes were not even used, so they were removed. Please report any problems arising from this! We do not have a lot of HAML test cases.

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

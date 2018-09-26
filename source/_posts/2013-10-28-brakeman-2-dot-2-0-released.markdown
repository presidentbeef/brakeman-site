---
layout: post
title: "Brakeman 2.2.0 Released"
date: 2013-10-28 10:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This is a small release, with some bug and false positive fixes alongside initial support for Rails engines and a new check for detailed exceptions.

*Changes since 2.2.0:*

 * Support scanning Rails engines ([Geoffrey Hichborn](https://github.com/phene))
 * Ignore redirects to models using `friendly_id` ([AJ Ostrow](https://github.com/aj0strow))
 * Add check for detailed exceptions in production ([#391](https://github.com/presidentbeef/brakeman/issues/391))
 * Use Rails version from Gemfile if it is available ([#398](https://github.com/presidentbeef/brakeman/issues/398))
 * Only add routes with actual names ([#395](https://github.com/presidentbeef/brakeman/issues/395))
 * Reduce command injection false positives

### Rails Engines

[Geoffrey Hichborn](https://github.com/phene) added support for checking Rails engines paths when searching for controllers, models, and views. Please let us know if there are any issues or files missed with this change.

([changes](https://github.com/presidentbeef/brakeman/pull/397))

### Redirects with Friendly ID

Thanks to [AJ Ostrow](https://github.com/aj0strow), Brakeman should no longer warn on redirects to models using `friendly_id`.

([changes](https://github.com/presidentbeef/brakeman/pull/400))

### Detailed Exceptions

[Nathaniel Talbott](https://github.com/ntalbott) suggested checking that detailed exceptions (treating requests as local) are not enabled in production.

Brakeman now generates a warning in a new category called "[Information Disclosure](http://brakemanscanner.org/docs/warning_types/information_disclosure/)" if `config.consider_all_requests_local` is set to `true` in production or a controller overrides `show_detailed_exceptions?` to return something other than `false`.

Please see the [changes](https://github.com/presidentbeef/brakeman/pull/396) regarding the new category and two new warning codes associated with these warnings.

### Better Version Detection

Brakeman now uses the Rails version found in `Gemfile` or `Gemfile.lock` to determine when to enable Rails 3/4 mode, which seems obvious in retrospect. This required swapping when the `Gemfile` and the configuration files are processed.

([changes](https://github.com/presidentbeef/brakeman/pull/402))

### Rails 3 Routes 

A small fix prevents Brakeman from raising an error when a route is a redirect or any value other than a string or symbol.

([changes](https://github.com/presidentbeef/brakeman/pull/403))

### Command Injection False Positives

There should be fewer false positives for command injection when interpolated values are literals. The check also now ignores commonly used values `RAILS_ROOT`, `Rails.env`, and `Rails.root`.

Additionally, reported "dangerous" values (`user_input` in JSON reports) for command injection are more specific. For example:

    system "rm -rf #{some_var}"

used to report the entire string `"rm -rf #{some_var}"` as dangerous, even though it's really warning about the interpolation of `some_var`. Now Brakeman will report the first potentially dangerous interpolated value. Note that this does not change fingerprints for existing warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/404))

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

### Verification

The SHA-1 for the Brakeman 2.2.0 gem is:

    f3a2b369bda79c677a913cdb2350cbda8bce8a90  brakeman-2.2.0.gem

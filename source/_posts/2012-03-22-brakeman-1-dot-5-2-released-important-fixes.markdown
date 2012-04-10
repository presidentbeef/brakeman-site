---
layout: post
title: "Brakeman 1.5.2 Released - Important Fixes"
date: 2012-03-22 13:34
comments: true
categories: 
---

This is update includes some important fixes. All users of the `rails_xss` plugin are particularly encouraged to upgrade.

_Changes since 1.5.1:_

 * Fix handling of views when using `rails_xss`
 * Fix rescanning of lib files (Neil Matatall)
 * Fix `link_to` checks for Rails 2.0 and 2.3
 * Revert to `ruby_parser` 2.3.1 for Ruby 1.8 parsing
 * Only warn on user input in render paths
 * Output stack trace on interrupt when debugging
 * Ignore user input in if statement conditions
 * Fix --skip-files option with Ruby 1.8


### Views with rails\_xss

Some previous changes to make sure Brakeman was processing ERB views the same way as the `rails_xss` plugin unfortunately broke the processing of those views.

These changes caused Brakeman to not report *any* output from ERB views when the `rails_xss` plugin was in use, hiding any XSS vulnerabilities in those views.

This now fixed, so if you are using the `rails_xss` plugin, it is highly recommended to upgrade.

### Rescanning lib/ Files

Rescanning changed files in the `lib` directory was broken, but Neil fixed it!

### link\_to Checks

In Rails 2.3, the URL is escaped, but not the body of the link. In Rails 2.0, neither argument is escaped.

In this release, the check for XSS in `link_to` has been updated to handle `link_to` with blocks and to warn in Rails 2.0.x if any user input is used as an argument.  

### Revert to ruby\_parser for Ruby 1.8

Brakeman has been using a vendored version of [ruby\_parser](https://github.com/seattlerb/ruby_parser) with some updates to Ruby 1.9 syntax parsing. Unfortunately, that version also introduced some regressions for parsing Ruby 1.8 syntax.

To handle this, Brakeman will now only use the vendored version for 1.9 parsing, but the regular gem version for 1.8 syntax parsing. This should fix some parse errors people are seeing for Ruby 1.8 apps.

### Dynamic Render Path Updates

The check for dynamic render paths was not very good, but it is better now. "Dynamic Render Path" warnings should only be raised when user input is actually used to determine what view, partial, or file to render.

### Stacktrace Output

Brakeman will now output a stacktrace if interrupted while running with the `-d` option. This is mostly helpful when Brakeman appears to "hang". 

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues)!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

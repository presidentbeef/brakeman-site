---
layout: post
title: "Brakeman 1.9.3 Released"
date: 2013-03-01 09:22
comments: true
categories: 
---

_Changes since 1.9.2_:

 * Add warning fingerprints
 * Add check for unsafe reflection ([Gabriel Quadros](https://github.com/gquadros))
 * Add support for Slim templates ([#214](https://github.com/presidentbeef/brakeman/issues/214))
 * Add check for skipping authentication methods with blacklist ([#199](https://github.com/presidentbeef/brakeman/issues/199))
 * Add render path to JSON report
 * Remove empty tables from reports ([Owen Ben Davies](https://github.com/obduk))
 * Handle `prepend/append_before_filter`
 * Performance improvements when handling branches
 * Fix processing of `production.rb` ([#264](https://github.com/presidentbeef/brakeman/issues/264))
 * Fix version check for Ruby 2.0
 * Expand HAML dependency to include 4.0 ([#263](https://github.com/presidentbeef/brakeman/issues/263))
 * Scroll errors into view when expanding in HTML report

### Warning Fingerprints and New Identifiers

*This is a breaking change: `brakeman --compare` will not work with reports generated from earlier versions.* 

Tracking of new and fixed warnings is often required when integrating Brakeman with other tools. Current approaches rely on fragile values such as the warning messages or formatting of the code output.

Additionally, warnings are grouped into large categories, such as "SQL Injection". Sometimes more fine-grained categorization is required that does not rely on a value intended for display that may need to changed.

With these two issues in mind, warnings now have a "warning code" and a "fingerprint". Warning codes are integers which will never change and provide more specific categorization of warnings. For example, each CVE has a separate code. This should make tracking and sorting warnings easier, but also allow for fixes to warning category names in the future.

The warning fingerprint is a SHA256 hash of five values:

 * Warning code
 * S-expression of code that caused the warning
 * Location (i.e., template name or class/method)
 * Relative file path
 * Confidence level

Note that line numbers are *not* included. Identical warnings on different lines will have the same fingerprint. External tools can make the decision for how to handle this situation.

Warning fingerprints allow quick comparison of warnings (either by fingerprint, or fingerprint + line number) but are also less fragile than existing approaches. The fingerprint will not change if the warning category (meant for display) changes, if the formatting of the code changes, or if the line number changes (e.g., some blank lines are added at the top of a file).

If there are any issues with fingerprints, please report them before Brakeman 2.0!

([changes](https://github.com/presidentbeef/brakeman/pull/280))

### Check for Unsafe Constant Creation

Gabriel Quadros has contributed a check for methods that create constants (usually classes) from user input. [His blog post](http://blog.conviso.com.br/2013/02/exploiting-unsafe-reflection-in.html) on the subject provides a good explanation of why this should be considered very dangerous. 

([changes](https://github.com/presidentbeef/brakeman/pull/274))

### Support for Slim

Support for templates using [Slim](http://slim-lang.com/) is now here! This should be considered experimental, as it has not yet been tested on a wide set of applications. Also, thanks [tubaxenor](https://github.com/tubaxenor) for reporting a require issue with this change.

Please report any issues, especially false negatives!

([changes](https://github.com/presidentbeef/brakeman/pull/271))

### Check for Skipping of Authentication Methods

The check for `skip_before_filter`s using `except` instead of `only` has been expanded to include authentication filters from popular libraries.

([changes](https://github.com/presidentbeef/brakeman/pull/268))

### Render Paths in JSON Reports

In HTML reports, templates which have a render path longer than one entry have been "expandable" to show the entire render path instead of just one level up. For example, a partial is usually rendered from a view, which is rendered from a controller action.

JSON reports now also include this information in the `render_path` value.

([changes](https://github.com/presidentbeef/brakeman/pull/279))

### No Empty Report Tables 

Owen Ben Davies contributed a patch to hide empty warning tables in the text and HTML reports. Looks much cleaner, thanks Owen!

([changes](https://github.com/presidentbeef/brakeman/pull/282))

### Handle (Pre|Ap)pended Filters  

Brakeman will now recognize before filters added with `prepend_before_filter` and `append_before_filter`.

([changes](https://github.com/presidentbeef/brakeman/pull/266))

### Branching Performance Improvements

It is entirely embarrassing, but Brakeman stopped working on Redmine some time ago due to how assignments in `if` expressions are handled.

In order to be somewhat flow sensitive, Brakeman combines variables assignments in `if` branches into `or` expressions. This captures the possible values a variable may have. However, Brakeman was doing that for *every* assignment in an `if` branch, even if there were multiple assignments to the same variable in the same branch (i.e., the value was not actually branching since the assignments were sequential). This release fixes that issue.

Additionally, simple arithmetic operations are now distributed across `or` expressions containing simple values (strings or numbers at this point), providing some memory savings.

([changes](https://github.com/presidentbeef/brakeman/pull/270))

### Fix Processing of Production Environment Settings

Processing of `production.rb` has been broken for some time, but poor test coverage meant it went unnoticed. But it is fixed now, so settings in `production.rb` should override those found in `environment.rb`. This only applies to Rails 3 applications.

([changes](https://github.com/presidentbeef/brakeman/pull/265))

### Fix Version Check for Ruby 2.0

Brakeman appears to work fine with Ruby 2.0, but the version check for Ruby 1.9 (which affected some behavior and checks) needed to be modified to include 2.0. Definitely report any issues with Ruby 2.0!

([changes](https://github.com/presidentbeef/brakeman/pull/277))

### Allow HAML 4.0

There appear to be no changes in HAML 4.0 that affect Brakeman, so the gem dependency has been expanded to include the 4.x series.

([changes](https://github.com/presidentbeef/brakeman/pull/269))

### Fix Error Show/Hide in HTML Report

Now clicking on "Exceptions" to show or hide scan errors will keep the errors in view.

([changes](https://github.com/presidentbeef/brakeman/pull/267))

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

### Roadmap

The [Brakeman roadmap](https://github.com/presidentbeef/brakeman/wiki/Roadmap) has one more release (1.9.4) planned before 2.0. The next release will likely only include bug and false positive fixes. Brakeman 2.0 will *definitely* include breaking changes, especially for JSON reports.

---
layout: post
title: "Brakeman 1.1 Released"
date: 2011-12-21 19:12
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---

This was supposed to be a 1.0.1 release, but quite a bit of code changed.

Changes since 1.0:

 * Relax required versions for dependencies (this is for Bundler users)
 * Performance improvements for source processing
 * Better progress reporting
 * Handle basic operators like << + - * /
 * Rescue more errors to prevent Brakeman from completely bailing out
 * Compatibility with newer Haml versions
 * Fix some 1.9 warnings

### Relax Dependencies

The version dependencies for Brakeman have been relaxed somewhat, so it should work fine if included in a Rails 3 Gemfile. Unfortunately, this makes it a little harder to be sure it will work with all setups. Please report any problems!

### Performance Improvements

The 1.0 release reduced the time taken for running the vulnerability checks, but (unrelatedly) the time for processing the source code increased.

This release makes some improvements that should improve scan times. If it takes an intolerable amount of time for scans (more than 5-10 minutes), try using the `--faster` option. This will possibly report fewer vulnerabilities, but should be much faster.

### Progress Reporting

Brakeman will now provide better feedback about its progress while processing applications. For even more output, use the `--debug` option.

### Handle More Operators

See [here](https://github.com/presidentbeef/brakeman/wiki/Using-Brakeman::AliasProcessor) for the kinds of simple processing Brakeman can do.

### Rescue More Errors

Brakeman does its best to never completely abort execution and tries to always provide an analysis of whatever it can manage. This release rescues exceptions that may occur while processing configurations and Gemfiles.

### Problems

If you run into any problems, don't hesitate to send a tweet to [@Brakemanscanner](http://twitter.com/brakemanscanner) or [file an issue](https://github.com/presidentbeef/brakeman/issues) on GitHub!

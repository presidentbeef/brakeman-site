---
layout: post
title: "Brakeman 1.0 Release Candidate Available"
date: 2011-12-05 14:04
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---

Because there have been some major changes since 0.9.2, I have released a release candidate just in case there are problems. Please try it out and report any issues!

    gem install brakeman --pre

**Changes:**

 * Brakeman can now be used as a library
 * Faster call search
 * Add option to return error code if warnings are found (tw-ngreen)
 * Allow truncated messages to be expanded in HTML
 * Keep expanded context in HTML output
 * Fix summary when using warning thresholds
 * Better support for Rails 3 routes
 * Reduce SQL injection duplicate warnings
 * Lower confidence on mass assignment with no user input
 * Ignore mass assignment using all literal arguments

### Brakeman as a Library

After some re-factoring, Brakeman can now be used as a library.

    require 'brakeman'
    
    Brakeman.run :app_path => 'my_app'

### Faster Call Search

Searching for calls, like many of the checks do, is significantly faster now. Any scans that spend the majority of the time running checks should be much quicker.

### Option to Return Error Code

`--exit-on-warn` will cause Brakeman to exit with an error code if any warnings are found.

### Fix Context in HTML Report

Truncated messages with no context are now able to be expanded when clicked.

Expanded context should remain visible in the browser, instead of sometimes scrolling out of view.

### Fix Report Summary

The summary in reports with warnings below the specified threshold will now only show the number of warnings in the actual report.

### Reduce Duplicate SQL Warnings

There should be fewer duplicate SQL injection warnings now.

## 1.0 Release

Next up is fixing Rubinius support, making Brakeman more useful as a library, and improving Rails 3 route processing.

If all is well, the 1.0 release will be ready in a couple days! Report bugs if you got 'em!

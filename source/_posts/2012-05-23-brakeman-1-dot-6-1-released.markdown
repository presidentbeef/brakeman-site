---
layout: blog
title: Brakeman 1.6.1 Released
date: 2012-05-23 12:45
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.6.0
  changes:
  - " * Major rewrite of CheckSQL"
  - " * Process actions mixed into controllers"
  - " * Check for inherited `attr_accessible` (Neil Matatall)"
  - " * Handle `render :template => ...`"
  - " * Report line number of highlighted value, if available"
  - " * Fix highlighting of HTML escaped values in HTML report"
  - " * Fix rescanning of deleted templates"
---


Wow, it's been over a month since the last release!

The major change in this version is a rewrite of the SQL injection check. Many more methods are covered, and there should be a reduction of false positives as well.


## Updated SQL Injection Check

`CheckSQL` has been completely revamped. Brakeman now has a much better understanding of the various ActiveRecord::FinderMethods and ActiveRecord::QueryMethods, as well as their options.

The check is also more conservative about what it warns on. Previously, since string interpolation is the main entry point for SQL injection in Rails, any interpolated value in a query would generate a warning. Now, "safe" sanitization methods, obviously safe methods like `to_i` and `id`, constants, strings, and other literal values should not cause warnings.

The "highlighted" value (or "user input") reported for SQL warnings should be much more accurate now, making it easier to determine why a warning was reported.

## Controller Mixins

Methods on controller mixins that are used as actions should now be processed as if they were defined in the controller itself.

## Check for Inherited Mass Assignment Protection

Since mass assignment protection via `attr_accessible` is inheritable, Brakeman will no longer warn about models whose parent uses `attr_accessible`.

## Template Option in Render

Somehow, the `:template` option for `render` has been ignored this whole time. Sorry!

## Better Line Numbers

Warnings which have a `:user_input` field use that value to "highlight" part of the code in the reported warning. This value usually corresponds to the code which actually caused the warning to be generated.

If a warning has this field, the line number of that code is used, instead of the starting line number of the entire piece of code. This often leads to more accurate and helpful line numbers.

## Highlighted Values in HTML Reports

Since the warnings output in HTML reports are HTML-escaped, there was a sometimes mismatch between the value that needed to be highlighted and the HTML warning output, causing nothing to be highlighted. This is fixed now. 

## Rescanning of Deleted Templates

In the rescanning logic, templates which are related to a changed file (a view or partial that is rendered, usually) will be rescanned. However, there is the possibility that the template which needs to be rescanned as a related file has been deleted as part of the set of changes. This caused the rescanning to blow up, but that has been fixed now.

---
layout: blog
title: Brakeman 2.1.1 Released
date: 2013-08-21 12:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 2.1.0
  changes:
  - More accurate results for model attribute warnings ([#385](https://github.com/presidentbeef/brakeman/issues/385))
  - Do not warn on `attr_accessible` using roles ([#372](https://github.com/presidentbeef/brakeman/issues/372))
  - New warning code for dangerous attributes in `attr_accessible`
  - Fix infinite loop when run as rake task ([Matthew Shanley](https://github.com/arkadyan))
  - Use exit code zero with `-z` if all warnings ignored ([#381](https://github.com/presidentbeef/brakeman/issues/381))
  - Respect ignored warnings in rescans ([#382](https://github.com/presidentbeef/brakeman/issues/382))
  - Respect ignored warnings in tabs format reports
  - Ignore dynamic controller names in routes
---


This is a small bug fix release. The only expected changes in warnings are for dangerous attributes in `attr_accessible`
and cross site scripting involving model attributes. Some warning fingerprints may change as a result of this update.


## More Accurate Model Matching

Model attributes which are reported as user input should now be reported more accurately. For example, instead of reporting `Model.find(1)` as user input, the entire attribute will be reported. For example: `Model.find(1).name`

As a side effect, several methods which were already intended to be ignored (such as `count`) will actually be ignored for XSS warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/386))

## attr\_accessible Check Updates

The check for potentially dangerous attributes whitelisted in `attr_accessible` has been updated to ignore attributes protected by roles. Additionally, it now has its own warning code to separate it from regular mass assignment warnings. 

([warning code change](https://github.com/presidentbeef/brakeman/pull/388), [role change](https://github.com/presidentbeef/brakeman/pull/384))

## Rake Task Fix

The last release included a method named `load_dependency` which handles calling `require` for optional dependencies. Unfortunately, Rails overrides `require` to call its own method called `load_dependency`. Rails is loaded when any `rake` command is used, so when Brakeman is run with Rake it causes an infinite loop between `load_dependency` and `require`. 

Thanks to [Matthew Shanley](https://github.com/arkadyan) for reporting the issue and providing a fix.

([changes](https://github.com/presidentbeef/brakeman/pull/375))

## Exit Code Fixed When Warnings Ignored

Brakeman will now return `0` when using `-z` and all reported warnings are ignored.

([changes](https://github.com/presidentbeef/brakeman/pull/375))

## Ignore Warnings in Rescans

Ignored warnings should now be ignored during rescans (for use with [guard-brakeman](https://github.com/guard/guard-brakeman)).

([changes](https://github.com/presidentbeef/brakeman/pull/383))

## Remove Ignored Warnings in Tabs Report

Ignoring warnings should now work for those using the Jenkins plugin.

([changes](https://github.com/presidentbeef/brakeman/pull/374))

## Ignore Dynamic Controller Name in Routes

Instead of completely aborting route processing, dynamic controller names are just ignored.

([changes](https://github.com/presidentbeef/brakeman/pull/379))

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

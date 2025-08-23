---
layout: blog
title: Brakeman 2.6.0 Released
date: 2014-06-06 09:04
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 2.5.0
  changes:
  - Improve default route detection in Rails 3/4 ([Jeff Jarmoc](https://github.com/jjarmoc))
  - Handle controllers and models split across files ([Patrick Toomey](https://github.com/ptoomey3))
  - Fix handling of `protected_attributes` gem in Rails 4 ([Geoffrey Hichborn](https://github.com/phene))
  - Add check for CVE-2014-0130
  - Add `find_by`/`find_by!` to SQLi check for Rails 4
  - Do not branch values for `+=`
  - Parse most files upfront instead of on demand
  - Fix CheckRender with nested render calls ([#484](https://github.com/presidentbeef/brakeman/issues/484))
  - Fix detection of `:host` setting in redirects ([#506](https://github.com/presidentbeef/brakeman/issues/506))
  - Ignore more model methods in redirects
  - Update to use RubyParser 3.5.0 ([Patrick Toomey](https://github.com/ptoomey3))
---


This release introduces significant changes to how and when files are parsed, which may introduce changes in existing warnings and errors.


## Improved Default Route Detection

In addition to Jeff Jarmoc's [awesome research](http://matasano.com/research/AnatomyOfRailsVuln-CVE-2014-0130.pdf) on CVE-2014-0130, he contributed much-needed improvements to detecting use of `:action` and `*action` in routes for Rails 3/4. This may result in more default routes warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/493))

## Multiple Files for Controllers and Models

([Patrick Toomey](https://github.com/ptoomey3)) contributed improvements which allow Brakeman to process controllers and models which may be defined in multiple files. The changes also improve how Brakeman handles controllers and models inside modules. This may alter some warnings and how some files are processed. Also, controllers and models may be associated with multiple files instead of just one.

(changes [here](https://github.com/presidentbeef/brakeman/pull/492) and [here](https://github.com/presidentbeef/brakeman/pull/482))

## Protected Attributes Gem

Thanks to ([Geoffrey Hichborn](https://github.com/phene)), Brakeman will now treat Rails 4 apps which use the [protected_attributes gem](https://github.com/rails/protected_attributes) like a Rails 3 app in regards to mass assignment.

([changes](https://github.com/presidentbeef/brakeman/pull/491))

## Check for CVE-2014-0130

Besides warning about more types of default routes in this release, Brakeman will also warn about [CVE-2014-0130](https://groups.google.com/d/msg/rubyonrails-security/NkKc7vTW70o/NxW_PDBSG3AJ) explicitly. If the application uses default routes, the warning will be high confidence, otherwise medium. Note Brakeman will categorize this issue as "Remote Code Execution", since [Jeff Jarmoc demonstrated]((http://matasano.com/research/AnatomyOfRailsVuln-CVE-2014-0130.pdf) rendering arbitrary files can lead to interpreting those files as ERB.

([changes](https://github.com/presidentbeef/brakeman/pull/502))

## SQL Injection in Find By

Rails 4 added the `find_by`/`find_by!` methods which just call `where(*args).take` and are therefore vulnerable to the same issues as `where`. This release will check these methods for SQL injection now.

([changes](https://github.com/presidentbeef/brakeman/pull/504))

## No Branching for +=

Code which used `+=` heavily in combination with many branches lead to very poor performance. The resulting information from the branches was rarely useful. However, since `+=` is buidling up a value (as opposed to replacing it), simply ignoring branches does not lose any of the values involved. Thus, the same vulnerabilities should be able to be detected even when losing flow sensitivity for `+=` assignments. For details, [see the changes](https://github.com/presidentbeef/brakeman/pull/499).

This change has improved processing on some files from over 30 minutes to under 1 second. If some files were processing slowly or had to be ignored previously, consider trying again with this release.

([changes](https://github.com/presidentbeef/brakeman/pull/499))

## Parsing Files Upfront

This release changes when files are parsed. Previously, files were read and parsed as they were processed. Now most files are read and parsed near the beginning of the scan instead. This has allowed for some internal cleanup and easier future changes. However, some bugs were fixed regarding sorting files which may cause warnings to change.

([changes](https://github.com/presidentbeef/brakeman/pull/501/))

## Nested Renders

`CheckRender` had a bug when processing a `render` call which contained another call to `render`. This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/485))

## Redirects with Chained Calls

The last release added support for checking if a `redirect_to` argument was setting the `:host` option. However, it did not work with chained calls like the [one reported here](https://github.com/presidentbeef/brakeman/issues/506). Now it should.

([changes](https://github.com/presidentbeef/brakeman/pull/507))

## Redirects to Models

More Rails 4 methods have been added and support for chained methods has been improved to prevent false positives when redirecting to a model instance.

([changes](https://github.com/presidentbeef/brakeman/pull/489))

## RubyParser Upgrade

The RubyParser dependency has been upgraded to 3.5.0 for Ruby 2.1 support. There are some issues with newlines and line number accuracy in newer versions (it is better for some code and worse for others) which has prevented further upgrades at the moment. 

([changes](https://github.com/presidentbeef/brakeman/pull/497))

## SHAs

The SHA1 sums for this release are

    0aae141108d92040f3553557a31ad117ac1c2ea6  brakeman-2.6.0.gem
    70c2353f31d4d04ba8d95c871062db31d5c6e981  brakeman-min-2.6.0.gem

---
layout: post
title: "Brakeman 3.1.1 Released"
date: 2015-09-23 08:11
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release includes two new checks and a number of bug fixes.

*Changes since 3.1.0*:

* Add check for user input in session keys
* Add optional check for use of MD5 and SHA1
* Fix absolute paths for Windows ([Cody Frederick](https://github.com/spcoder))
* Allow searching call index methods by regex ([Alex Ianus](https://github.com/aianus))
* Consider `j`/`escape_javascript` safe inside Haml JavaScript blocks ([#708](https://github.com/presidentbeef/brakeman/issues/708))
* Better Haml processing of `find_and_preserve` calls
* Fix chained assignment
* Treat `a.try(&:b)` like `a.b()`
* Add more Arel methods to be ignored in SQL ([#711](https://github.com/presidentbeef/brakeman/issues/711))
* Avoid warning when linking to decorated models ([#683](https://github.com/presidentbeef/brakeman/issues/683))
* Support newer terminal-table releases ([#709](https://github.com/presidentbeef/brakeman/issues/709))

### Session Manipulation Check

As suggested by [Joernchen](https://twitter.com/joernchen), Brakeman will now look for user input in session keys which can lead to session manipulation.

([changes](https://github.com/presidentbeef/brakeman/pull/720))

### Optional Check for Weak Hashes

An optional check to look for use of MD5 and SHA1 has been added to this release. Run with `-t WeakHash` to use just this optional check or `-A` to run all checks.

([changes](https://github.com/presidentbeef/brakeman/pull/722))

### Windows Paths

[Cody Frederick](https://github.com/spcoder) fixed an issue with determining absolute paths on Windows.

([changes](https://github.com/presidentbeef/brakeman/pull/714))

### Search for Methods by Regex

[Alex Ianus](https://github.com/aianus) re-introduced the ability to search the CallIndex with regular expressions for methods:

    tracker.find_call(method: /_something$/)

([changes](https://github.com/presidentbeef/brakeman/pull/710))

### Haml Processing

Haml users may have noticed warnings with `find_and_preserve(Haml::Filters::Javascript.render_with_options(...))` in them. This has been fixed so `find_and_preserve` is treated as though it just passes through its arguments. Calls to `render_with_options` will be treated as unescaped output. 

Along with this change, `j` and `escape_javascript` will be considered safe inside `:javascript` filters in Haml.

([changes](https://github.com/presidentbeef/brakeman/pull/716))

### Chained Assignment

Chained assignments like `a = b = c = 1` will now be handled correctly. This fixes [a very old issue from 2012](https://stackoverflow.com/questions/11314450/how-to-secure-link-to-variable-cross-site-scripting-vulnerabilities).

([changes](https://github.com/presidentbeef/brakeman/pull/718))

### Trying More

While Brakeman already treated `a.try(:b)` like `a.b()`, there is a surprising amount of code which does `a.try(&:b)`. This is totally unncessary, but Brakeman now handles it as well.

([changes](https://github.com/presidentbeef/brakeman/pull/717))

### More Arel Whitelisting

A number of Arel methods have been whitelisted to avoid warning about them inside SQL query building.

([changes](https://github.com/presidentbeef/brakeman/pull/719))

### Decorated Models in Links

If the Draper gem is used, Brakeman will ignore calls to `decorate` in `link_to`.

([changes](https://github.com/presidentbeef/brakeman/pull/721))

### terminal-table

Newer [terminal-table](https://github.com/tj/terminal-table) releases are supported now and the dependency has been relaxed.

([changes](https://github.com/presidentbeef/brakeman/pull/712))

### SHAs

The SHA1 sums for this release are

    cfd1840116c20b0b8932720fdaac09dd4e47091a  brakeman-3.1.1.gem
    603389da732d307a014af445a1f312415b65a682  brakeman-min-3.1.1.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter, joining the [mailing list](http://brakemanscanner.org/contact/), or hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman).

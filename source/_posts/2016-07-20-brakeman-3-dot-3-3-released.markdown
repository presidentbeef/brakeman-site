---
layout: blog
title: "Brakeman 3.3.3 Released"
date: 2016-07-20 18:11
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release is mostly bug fixes and internal improvements, although it may find more warnings due to indexing of view helpers.

* Index calls in view helpers
* Process inline template renders ([#672](https://github.com/presidentbeef/brakeman/issues/672))
* Show path when no Rails app found ([Neil Matatall](https://github.com/oreoshake))
* Avoid warning about hashes in `link_to` hrefs ([#897](https://github.com/presidentbeef/brakeman/issues/897))
* Improve return value guesses
* Ignore boolean methods in render paths
* Reduce open redirect duplicates
* Fix SymbolDoS error with unknown Rails version

## View Helpers

Calls in view helpers are now indexed, which means Brakeman will search them for potential vulnerabilities.

([changes](https://github.com/presidentbeef/brakeman/pull/907))

## Inline Templates

Brakeman will now process inline templates in controllers, if they are using ERB (the default):

    render :inline => "<%= params[:x].html_safe %>"

([changes](https://github.com/presidentbeef/brakeman/pull/905))

## Rails App Path

Thanks to [Neil Matatall](https://github.com/oreoshake), Brakeman will now display the path it tried to search for a Rails application if it cannot find it:

    Please supply the path to a Rails application (looking in /some/path/).

([changes](https://github.com/presidentbeef/brakeman/pull/909))

## Hashes as URLs

Brakeman will no longer warn about obvious hash arguments in the HREF for `link_to` calls, as well as handling `url_for` better.

([changes](https://github.com/presidentbeef/brakeman/pull/904))

## Return Values

In some cases, Brakeman attempts to determine the possible return value(s) of a method call.
This release includes a number of improvements to those guesses which may make some warnings easier to understand
and fix some false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/896))

## Render Path Booleans

The check for dynamic render paths will no longer warn about methods ending in `?`.

([changes](https://github.com/presidentbeef/brakeman/pull/899))

## Redirect Duplicates

This release refactored much of the warning duplicate tracking, and as such there should be fewer duplicate warnings about open redirects.

([changes](https://github.com/presidentbeef/brakeman/pull/901))

## SHAs

The SHA256 sums for this release are

    490bf7b47d4edbb29fd3f87c5dafa50aec2888d495b64275a635df324a8476e9  brakeman-3.3.3.gem
    793f1c69cca2681bdd0c98f11307ace4f1a43ed594dd45cbe5b67f0383e76e2f  brakeman-lib-3.3.3.gem
    dcc3a75b12f84cac582d383a375d3b85d033e25ba42af051bedcdc8b5377c2c5  brakeman-min-3.3.3.gem

## Reporting Issues

Thank you to everyone who reported bugs and contributed improvements in this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

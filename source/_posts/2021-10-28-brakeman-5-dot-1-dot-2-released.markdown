---
layout: post
title: "Brakeman 5.1.2 Released"
date: 2021-10-28 11:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Here's a small bugfix release with a big parser update!

Huge thanks as always to [Ryan Davis](https://github.com/sponsors/zenspider?o=esb) for maintaining `ruby_parser`.

_Changes since 5.1.1:_

* Updated `ruby_parser` ([Ryan Davis](https://www.zenspider.com/))
* Fix issue where the previous output is still visible ([Jason Frey](https://github.com/Fryguy))
* Handle cases where enums are not symbols ([#1627](https://github.com/presidentbeef/brakeman/issues/1627))
* Support newer Haml with `::Haml::AttributeBuilder.build`
* Fix sorting with `nil` line numbers

## Updated RubyParser

Once again, [Ryan Davis](https://github.com/sponsors/zenspider?o=esb) comes through with a great update of [ruby\_parser](https://github.com/seattlerb/ruby_parser)
including support for newer Ruby 2.7 and 3.0 syntaxes as well as many other fixes and improvements.

([changes](https://www.zenspider.com/releases/2021/10/ruby_parser-version-3-18-0-has-been-released.html))

## Output Cleanup

[Jason Frey](https://github.com/Fryguy) cleaned up the `Processing libs...` updates so it doesn't look like `Processing libs...ssed` anymore.

([changes](https://github.com/presidentbeef/brakeman/pull/1629))

## Enums Without Symbols

Calls to `enum` where the first argument is not a symbol will be ignored for now.

([changes](https://github.com/presidentbeef/brakeman/pull/1631))

## Newer Haml

In Haml 5.2.2 the `::Haml::AttributeBuilder.build` method started popping up and Brakeman was treating it as suspicious.

For now, ignoring it because it seems pretty safe.

([changes](https://github.com/presidentbeef/brakeman/pull/1637))

## Sorting with Missing Line Numbers

In some, apparently rare cases, if two warnings have the same confidence, warning type, and are in the same file, but have `nil` line numbers,
then it _could_ (but doesn't always) cause a sorting error.

([changes](https://github.com/presidentbeef/brakeman/pull/1641))

### Checksums

The SHA256 sums for this release are:

    d95b1cee8d751db8300c9390d8c90cf3e54f725c4d448f7ccfbdb9a723b6377a  brakeman-5.1.2.gem
    8e6a25a4da113269e70a0e536325e8a18b02745f23dea25ecf640c675961961c  brakeman-lib-5.1.2.gem
    7b272fa7efc2f25208614bd801993e2b161b4edbf8c423c93b6b13aaee09ae84  brakeman-min-5.1.2.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

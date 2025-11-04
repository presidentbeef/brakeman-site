---
layout: blog
title: "Brakeman 7.1.1 Released"
subtitle: "Performance improvements on macOS and lots of bug fixes"
date: 2025-11-03
version: "7.1.1"
changelog:
  since: "7.1.0"
  changes:
    - "Exclude directories before searching for files ([#1925](https://github.com/presidentbeef/brakeman/issues/1925))"
    - "Check for unsafe SQL when two arguments are passed to AR methods ([Patrick Brinich-Langlois](https://github.com/patbl))"
    - "Fix SQL injection check for `calculate` method ([Rohan Sharma](https://github.com/rsharma-figma))"
    - "Check each side of `or` SQL arguments ([#1935](https://github.com/presidentbeef/brakeman/issues/1935))"
    - "Consider `Tempfile.create.path` as safe input ([Ali Ismayilov](https://github.com/aliismayilov))"
    - "Fix false positive when calling `with_content` on ViewComponents ([Peer Allan](https://github.com/peerkleio))"
    - "Add `FilePath#to_path` for Ruby 3.5 compatibility ([S.H.](https://github.com/S-H-GAMELINKS))"
    - "Ignore attribute builder in Haml 6 ([#1952](https://github.com/presidentbeef/brakeman/issues/1952))"
    - "Word wrap text output in pager"
checksums:
  - hash: "629426b5d6496c75e3ffa2299e1ab1bb3ba721fea03d8808414c083660439498"
    file: "brakeman-7.1.1.gem"
  - hash: "0e7b06294c148fbe73008eb19507e59c3cb50ab61a62f679becd4b2b93e49249"
    file: "brakeman-lib-7.1.1.gem"
  - hash: "8a911bbb1fe531530bff61e9bdc7acb6a9b4cecc3fae7a6f2a840c58006743a6"
    file: "brakeman-min-7.1.1.gem"
permalink: /blog/:year/:month/:day/:title
---

## Faster File Search on MacOS 

Brakeman now pre-filters top-level directories to speed up file enumeration on MacOS. This can be significant when there are large numbers of files.

([changes](https://github.com/presidentbeef/brakeman/pull/1968))

## SQL Injection Detection Updates

[Patrick Brinich-Langlois](https://github.com/patbl) fixed a bug where ActiveRecord queries with two arguments would cause the query to be ignored.

([changes](https://github.com/presidentbeef/brakeman/pull/1936))

[Rohan Sharma](https://github.com/rsharma-figma) addressed an issue where calls to `calculate` only checked the third argument for dangerous values, when the second argument
is also vulnerable to SQL injection.

([changes](https://github.com/presidentbeef/brakeman/pull/1963))

Queries where the input is two or more values `or`ed together will now check all values in the argument (which can resolve false positives).

([changes](https://github.com/presidentbeef/brakeman/pull/1969))

## Safe Tempfile Paths

[Ali Ismayilov](https://github.com/aliismayilov) added `Tempfile.create.path` as a safe value to match existing behavior with `Tempfile.new.path`.

([changes](https://github.com/presidentbeef/brakeman/pull/1933))

## More ViewComponents

[Peer Allan](https://github.com/peerkleio) addressed a false positive when `with_content` is used with ViewComponents.

([changes](https://github.com/presidentbeef/brakeman/pull/1950))

## Pathname Ruby 3.5 Compatibility

[S.H.](https://github.com/S-H-GAMELINKS) fixed a future compatibility issue with Pathnames and Ruby 3.5.

([changes](https://github.com/presidentbeef/brakeman/pull/1965))

## More Haml 6 Fixes

`AttributeBuilder` will now be handled correctly in Haml 6 templates (i.e. ignored).

([changes](https://github.com/presidentbeef/brakeman/pull/1967))

## Word Wrapping

Brakeman will now word wrap text output when using the page (which is the default). This is especially helpful if using [brakeman-llm](https://github.com/presidentbeef/brakeman-llm).

([changes](https://github.com/presidentbeef/brakeman/pull/1961))

## Reporting Issues

Additional thanks to

* [Bryan Helmkamp](https://github.com/brynary) for fixing code coverage with [qlty](https://qlty.sh/)
* [Sunny Ripert](https://github.com/sunny) for [fixing up a mistake in the changelog](https://github.com/presidentbeef/brakeman/pull/1953)!
* [John Hawthorn](https://github.com/jhawthorn) for adding a [missing `</td>`](https://github.com/presidentbeef/brakeman/pull/1962) in the HTML report.

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

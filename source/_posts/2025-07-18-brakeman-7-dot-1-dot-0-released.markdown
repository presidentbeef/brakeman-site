---
layout: blog
title: "Brakeman 7.1.0 Released"
subtitle: "Haml 6 support, render shortcuts, and performance improvements"
date: 2025-07-18
version: "7.1.0"
changelog:
  since: "7.0.2"
  changes:
    - "Add Haml 6.x support ([#1914](https://github.com/presidentbeef/brakeman/issues/1914), [#1841](https://github.com/presidentbeef/brakeman/issues/1841), etc.)"
    - "Support render model shortcut ([#959](https://github.com/presidentbeef/brakeman/issues/959), [#1940](https://github.com/presidentbeef/brakeman/issues/1940), etc.)"
    - "Add `--ensure-no-obsolete-config-entries` option ([viralpraxis](https://github.com/viralpraxis))"
    - "Update JUnit report for CircleCI ([Philippe Bernery](https://github.com/pbernery))"
    - "Improve ignored warnings layout in HTML report ([Sebastien Savater](https://github.com/inkstak))"
    - "Only load escape functionality from cgi library ([Earlopain](https://github.com/Earlopain))"
    - "Add EOL dates for Rails 8.0 and Ruby 3.4"
    - "Use lazy file lists for AppTree"
checksums:
  - hash: "bbc708a75a53008490c8b9600b97fa85cb3d5a8818dd1560f18e0b89475d48af"
    file: "brakeman-7.1.0.gem"
  - hash: "b5263ca27a725ad38fb98aa83908b0285eee46c29096eb4fb0b36b2795bbb082"
    file: "brakeman-lib-7.1.0.gem"
  - hash: "0a141eaf08f864680af69c6642f9cf855be3eb89c3d5a3f5b0bd182f9eba2d82"
    file: "brakeman-min-7.1.0.gem"
---

## Haml 6 Support

Brakeman now ships with and supports Haml 6.

To continue using Brakeman with Haml 5.x, please use the `brakeman-lib` or `brakeman-min` gems.

([changes](https://github.com/presidentbeef/brakeman/pull/1944))

## Render Shortcuts

After many, many years, Brakeman now supports shortcuts where specific models or collections are rendered. For example: `render User.find(..)` or `render User.all`

Brakeman does not currently support rendering of collections with mixed types of models.

([changes](https://github.com/presidentbeef/brakeman/pull/1948))

## Fail on Obsolete Ignored Warnings

When Brakeman is configured to ignore warnings, but then those warnings aren't found, Brakeman reports "obsolete ignored warnings".

[viralpraxis](https://github.com/viralpraxis) added the `--ensure-no-obsolete-config-entries` option to return a failure exit code if there are obsolete entries.

([changes](https://github.com/presidentbeef/brakeman/pull/1921))

## JUnit Report for CircleCI

[Philippe Bernery](https://github.com/pbernery) has fixed JUnit reports to be compatible with CircleCI (again). Thanks!

([changes](https://github.com/presidentbeef/brakeman/pull/1934))

## Better Ignored Warnings Layout

Speaking of ignored warnings, [Sebastien Savater](https://github.com/inkstak) has improved the layout in the HTML report to make it easier to read notes for ignored warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/1941))

## CGI Loading

In preparation for [Ruby 3.5](https://bugs.ruby-lang.org/issues/21258), [Earlopain](https://github.com/Earlopain) updated Brakeman to explcitly load `cgi/escape` instead of the entire CGI library.

([changes](https://github.com/presidentbeef/brakeman/pull/1938))

## Lazy File Lists

Use lazy file lists when managing files in `Brakeman::AppTree`. This provides a small (~9%) speed improvement for large applications.

([changes](https://github.com/presidentbeef/brakeman/pull/1913))

## Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

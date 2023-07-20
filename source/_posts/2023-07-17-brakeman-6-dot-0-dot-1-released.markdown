---
layout: post
title: "Brakeman 6.0.1 Released"
date: 2023-07-20 13:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Very tiny release this time!

_Changes since 6.0.0:_

* Accept strings for `load_defaults` version ([#1784](https://github.com/presidentbeef/brakeman/issues/1784))
* Bundle latest `ruby_parser`

### Strings for `load_defaults`

While the default for Rails generators and documentation is to use floats for versions, e.g. `load_defaults 6.1`, internally it uses strings. It appears quite a few apps also use strings.

Now Brakeman supports and uses strings.

([changes](https://github.com/presidentbeef/brakeman/pull/1785))

### Latest RubyParser

Bundled with `ruby_parser` 3.20.3, which includes additional support for Ruby 3.2 syntax.

### Checksums

The SHA256 sums for this release are:

    39641c63bc247bbdf993a349de90a13e146c464c872191f2adc12555bde591be  brakeman-6.0.1.gem
    e029fbd43c97bbb9c084fa4f0e13ee259bf193b79d66ba7ef94fa9496bab62cd  brakeman-lib-6.0.1.gem
    ef2ff1234ba2a9e7216a0a047b9df0def8c3b8d162d29853c907238901353a54  brakeman-min-6.0.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

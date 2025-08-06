---
layout: blog
title: Brakeman 6.0.1 Released
date: 2023-07-20 13:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 6.0.0
  changes:
  - Accept strings for `load_defaults` version ([#1784](https://github.com/presidentbeef/brakeman/issues/1784))
  - Bundle latest `ruby_parser`
checksums:
- hash: 39641c63bc247bbdf993a349de90a13e146c464c872191f2adc12555bde591be
  file: brakeman-6.0.1.gem
- hash: e029fbd43c97bbb9c084fa4f0e13ee259bf193b79d66ba7ef94fa9496bab62cd
  file: brakeman-lib-6.0.1.gem
- hash: ef2ff1234ba2a9e7216a0a047b9df0def8c3b8d162d29853c907238901353a54
  file: brakeman-min-6.0.1.gem
---


Very tiny release this time!


## Strings for `load_defaults`

While the default for Rails generators and documentation is to use floats for versions, e.g. `load_defaults 6.1`, internally it uses strings. It appears quite a few apps also use strings.

Now Brakeman supports and uses strings.

([changes](https://github.com/presidentbeef/brakeman/pull/1785))

## Latest RubyParser

Bundled with `ruby_parser` 3.20.3, which includes additional support for Ruby 3.2 syntax.


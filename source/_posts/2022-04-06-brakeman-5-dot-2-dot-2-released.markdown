---
layout: post
title: "Brakeman 5.2.2 Released"
date: 2022-04-06 08:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

_Changes since 5.2.1:_

* Respect equality in `if` conditions ([#1683](https://github.com/presidentbeef/brakeman/issues/1683))
* Update message for unsafe reflection ([Pedro Baracho](https://github.com/pedropb))
* Handle `nil` when joining values ([Dan Buettner](https://github.com/Capncavedan))
* Add additional String methods for SQL injection check ([#1669](https://github.com/presidentbeef/brakeman/issues/1669))
* Update `ruby_parser` for Ruby 3.1 support ([Merek Skubela](https://github.com/sqbell))

### Equality Checks in Conditions

When Brakeman comes across code like:

```ruby
if x == 1
  # do something with x
end
```

It will now assume `x` is `1` inside of the `if` branch.

([changes](https://github.com/presidentbeef/brakeman/pull/1681))

### Unsafe Reflection Messages

[Pedro Baracho](https://github.com/pedropb) updated the messages for unsafe reflection to be clearer.

([changes](https://github.com/presidentbeef/brakeman/pull/1670))

### Another String Joining Fix

[Dan Buettner](https://github.com/Capncavedan) fixed an exception when a `nil` gets into a string joining operation.


([changes](https://github.com/presidentbeef/brakeman/pull/1686))

### More SQL Injection

When Brakeman checks for SQL injection, there are a number of methods (like `to_s` or `strip`) that essentially return the string itself.

This list of methods has been expanded to include `chop`, `lstrip`, `rstrip`, `scrub`, and `tr`.

([changes](https://github.com/presidentbeef/brakeman/pull/1682))

### Update RubyParser

This version of Brakeman includes [RubyParser 3.19](https://www.zenspider.com/releases/2022/03/ruby_parser-version-3-19-0-has-been-released.html) which adds support for Ruby 3.1 syntax. Thanks [Merek Skubela](https://github.com/sqbell)!

([changes](https://github.com/presidentbeef/brakeman/pull/1695))

### Checksums

The SHA256 sums for this release are:

    246c9540f5d90fbde39c95999d319f9706bf79668f66bb35419825c1cbef61ae  brakeman-5.2.2.gem
    1b559598d78919c0f6f3a8e8602b86ab35f825810b1d7daf872b7791b452e78b  brakeman-lib-5.2.2.gem
    4c34dcc1900bf872254eee2b313b1634ffacc9002fd7d26b8390259318cf6194  brakeman-min-5.2.2.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

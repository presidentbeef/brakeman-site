---
layout: post
title: "Brakeman 5.4.0 Released"
date: 2022-11-17 21:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Special thanks to [Bart de Water](https://github.com/bdewater) and [Ryan Cartner](https://github.com/tehryanx) for proposing new rules!

_Changes since 5.3.1:_

* Add check for weak RSA key sizes and padding modes ([#1736](https://github.com/presidentbeef/brakeman/issues/1736))
* Add check for absolute paths issue with Pathname ([#1721](https://github.com/presidentbeef/brakeman/issues/1721))
* Handle multiple values and splats in case/when ([#1730](https://github.com/presidentbeef/brakeman/issues/1730))
* Ignore more model methods in redirects ([#1723](https://github.com/presidentbeef/brakeman/issues/1723))
* Fix `load_rails_defaults` overwriting settings in the Rails application ([James Gregory-Monk](https://github.com/jamgregory))
* Use relative paths for CodeClimate report format ([Mike Poage](https://github.com/RubyBrewsday))

### Check RSA Key Sizes and Padding Modes

Brakeman now warns on:

* RSA key sizes less than 2048 bits
* Use of padding modes other than OAEP (including `none`)

([changes](https://github.com/presidentbeef/brakeman/pull/1737))

### Unexpected Absolute Paths

When joining paths using `Pathname#join`, any arguments that start with a forward slash (`/`) will cause the rest of the path to be relative to that absolute path. This may cause unexpected behavior and deviates from how `File.join` works.

```ruby
Pathname.new('a').join('b', '/c', 'd')
 => #<Pathname:/c/d>
```

(There are more `Pathname` methods with this issue - to be added in a future release.)

([changes](https://github.com/presidentbeef/brakeman/pull/1733))

### Multiple Values in `when`s

If a `when` clause contains only 'safe' values, Brakeman will treat the `case` value as safe:

```ruby
y = [1, 2, 3]

case x
when *y
  maybe_dangerous(x) # `x` must be an integer, so not dangerous
end
```

([changes](https://github.com/presidentbeef/brakeman/pull/1734))

### Ignore More Redirects

More model methods are ignored in redirects:

* `first!`
* `last!`
* `sole`
* `find_by_sole`

([changes](https://github.com/presidentbeef/brakeman/pull/1732))

### Rails Defaults

[James Gregory-Monk](https://github.com/jamgregory) fixed how Rails default configuration values are set so overrides were properly handled.

([changes](https://github.com/presidentbeef/brakeman/pull/1719))

### Checksums

The SHA256 sums for this release are:

    bab990760949e999c5d52b297d8badda376754eb296c91abf829def733ed9d51  brakeman-5.4.0.gem
    2b5a0cd5845b8c0e1b83e00122654af48b025ac3e6625c9ecbc5535226068416  brakeman-lib-5.4.0.gem
    fcbd60456c5db62767d143696e1edf8e4eaee734f2a039903aeca7bb4e6b3dbf  brakeman-min-5.4.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

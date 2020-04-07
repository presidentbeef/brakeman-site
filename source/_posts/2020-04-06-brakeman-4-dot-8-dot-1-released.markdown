---
layout: post
title: "Brakeman 4.8.1 Released"
date: 2020-04-06 10:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Just a little bug fix release.

_Changes since 4.8.0:_

* Warn about global(!) mass assignment
* Check SQL query strings using `String#strip` or `String.squish` ([#1459](https://github.com/presidentbeef/brakeman/issues/1469))
* Handle non-symbol keys in `locals` hash for `render` ([#1465](https://github.com/presidentbeef/brakeman/issues/1465))
* Index calls in render arguments ([#1459](https://github.com/presidentbeef/brakeman/issues/1459))

### Global Mass Assignment

Strong parameters can be disabled with:

```ruby
ActionController::Parameters.permit_all_parameters = true
```

Brakeman will now warn about this (very rare) configuration.

([changes](https://github.com/presidentbeef/brakeman/pull/1464))

### Squished and Stripped SQL

Brakeman will now check string targets of `squish` or `strip`.

For example:

```ruby
ActiveRecord::Base.connection.execute "SELECT * FROM #{user_input}".squish
```

([changes](https://github.com/presidentbeef/brakeman/pull/1470))

### Non-Symbol Keys in Locals Hash

Using a value other than symbol literals as keys in the `locals` hash for `render` will no longer cause an error.

([changes](https://github.com/presidentbeef/brakeman/pull/1468))

### Render Arguments

Calls made as arguments to `render` will be indexed and checked for all vulnerability types, like every other method call.

([changes](https://github.com/presidentbeef/brakeman/pull/1460))

### Checksums

The SHA256 sums for this release are:

    5f3cc763fce471434adc33aa251298fa24ea2a1c01ef2549aec55be4b5b14d46  brakeman-4.8.1.gem
    c4a95b450fb7ec2440e68640a0821e3a6b62ea34f665e78264ba0b332e98e5df  brakeman-lib-4.8.1.gem
    ada41dbfc3a436c062cd44161893249654caf43296801599303952f6261f2e5e  brakeman-min-4.8.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


---
layout: blog
title: Brakeman 4.8.1 Released
date: 2020-04-06 10:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.8.0
  changes:
  - Warn about global(!) mass assignment
  - Check SQL query strings using `String#strip` or `String.squish` ([#1459](https://github.com/presidentbeef/brakeman/issues/1469))
  - Handle non-symbol keys in `locals` hash for `render` ([#1465](https://github.com/presidentbeef/brakeman/issues/1465))
  - Index calls in render arguments ([#1459](https://github.com/presidentbeef/brakeman/issues/1459))
checksums:
- hash: 5f3cc763fce471434adc33aa251298fa24ea2a1c01ef2549aec55be4b5b14d46
  file: brakeman-4.8.1.gem
- hash: c4a95b450fb7ec2440e68640a0821e3a6b62ea34f665e78264ba0b332e98e5df
  file: brakeman-lib-4.8.1.gem
- hash: ada41dbfc3a436c062cd44161893249654caf43296801599303952f6261f2e5e
  file: brakeman-min-4.8.1.gem
---


Just a little bug fix release.


## Global Mass Assignment

Strong parameters can be disabled with:

```ruby
ActionController::Parameters.permit_all_parameters = true
```

Brakeman will now warn about this (very rare) configuration.

([changes](https://github.com/presidentbeef/brakeman/pull/1464))

## Squished and Stripped SQL

Brakeman will now check string targets of `squish` or `strip`.

For example:

```ruby
ActiveRecord::Base.connection.execute "SELECT * FROM #{user_input}".squish
```

([changes](https://github.com/presidentbeef/brakeman/pull/1470))

## Non-Symbol Keys in Locals Hash

Using a value other than symbol literals as keys in the `locals` hash for `render` will no longer cause an error.

([changes](https://github.com/presidentbeef/brakeman/pull/1468))

## Render Arguments

Calls made as arguments to `render` will be indexed and checked for all vulnerability types, like every other method call.

([changes](https://github.com/presidentbeef/brakeman/pull/1460))


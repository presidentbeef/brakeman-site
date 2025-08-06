---
layout: blog
title: Brakeman 4.9.1 Released
date: 2020-09-04 12:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.9.0
  changes:
  - Use version from `active_record` for non-Rails apps ([Ulysse Buonomo](https://github.com/BuonOmo))
  - Check `chomp`ed strings for SQL injection ([#1509](https://github.com/presidentbeef/brakeman/issues/1509))
  - Always set line number for joined arrays ([#1499](https://github.com/presidentbeef/brakeman/issues/1499))
  - Avoid warning about missing `attr_accessible` if `protected_attributes` gem is
    used ([#1512](https://github.com/presidentbeef/brakeman/issues/1512))
checksums:
- hash: 5a17706b1da4886f1b6864c3ffff1ab40684f3f7b4d667138227c467ebccb0f7
  file: brakeman-4.9.1.gem
- hash: 8bb3d88f9786e9f08c24d38e88c40adf02f4a47b17de8c1c816f7e174de476a4
  file: brakeman-lib-4.9.1.gem
- hash: 8eae3eec1ebab0cf3b29ea50089f613b0d8e544ae4c332f1f5e64a240e8a0a94
  file: brakeman-min-4.9.1.gem
---


This release was prompted by the release of [ruby\_parser 3.15.0](https://www.zenspider.com/releases/2020/08/ruby_parser-version-3-15-0-has-been-released.html), which includes a _lot_ of fixes and improvements, including support for some Ruby 2.7 syntax.


## Check ActiveRecord Version

For non-Rails applications that are using ActiveRecord, use the version of `active_record` to set Brakeman's guess at a Rails version. Thanks to [Ulysse Buonomo](https://github.com/BuonOmo).

_Note: It is not recommended to run Brakeman on non-Rails applications... but no one is going to stop you if you want really to._

([changes](https://github.com/presidentbeef/brakeman/pull/1506))

## SQL Injection with Chomp

Brakeman will now check for string interpolation inside strings that have `chomp` called on them.

([changes](https://github.com/presidentbeef/brakeman/pull/1511))

## Joined Arrays Line Number

Fixed a small, unlikely bug where joining two arrays where Brakeman doesn't have a line number for either of them would raise an exception.
Not really sure how that happens, though.

([changes](https://github.com/presidentbeef/brakeman/pull/1503))

## Protected Attributes

When using the `protected_attributes` gem, it is allowed but not required to set `attr_accessible` on models.

Brakeman will no longer warn about missing `attr_accessible` when `protected_attributes` is used.

([changes](https://github.com/presidentbeef/brakeman/pull/1513))

## Update RubyParser

As noted above, this version of Brakeman ships with an updated version of ruby\_parser.


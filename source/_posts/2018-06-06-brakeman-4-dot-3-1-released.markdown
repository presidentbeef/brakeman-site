---
layout: post
title: "Brakeman 4.3.1 Released"
date: 2018-06-06 19:55
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Mostly false positive reduction and bug fixes in this one!

_Changes since 4.3.0:_

* Add `:BRAKEMAN_SAFE_LITERAL` to represent known-safe literals
* Handle `Array#map` and `Array#each` over literal arrays ([#1208](https://github.com/presidentbeef/brakeman/issues/1208) / [#1224](https://github.com/presidentbeef/brakeman/issues/1224))
* Use safe literal when accessing literal hash with unknown key ([#1213](https://github.com/presidentbeef/brakeman/issues/1213))
* Allow `symbolize_keys` to be called on `params` in SQL ([Jacob Evelyn](https://github.com/JacobEvelyn))
* Improve handling of conditionals in shell commands ([Jacob Evelyn](https://github.com/JacobEvelyn))
* Avoid deprecated use of ERB in Ruby 2.6 ([Koichi ITO](https://github.com/koic))
* Ignore `Object#freeze`, use the target instead ([#1211](https://github.com/presidentbeef/brakeman/issues/1211))
* Ignore `foreign_key` calls in SQL ([#1202](https://github.com/presidentbeef/brakeman/issues/1202))
* Handle `included` calls outside of classes/modules ([#1209](https://github.com/presidentbeef/brakeman/issues/1209))
* Fix error when setting line number in implicit renders ([#1210](https://github.com/presidentbeef/brakeman/issues/1210))

### Safe Literals

This version of Brakeman introduces a new way of handling "known safe" values (integers, string literals, etc.) where the *exact* value is unknown. The uses of the values will be replaced with `:BRAKEMAN_SAFE_LITERAL` instead of actual values, as Brakeman had done previously. The new approach avoids some unhelpful side-effects and allows for more of this kind of thing in the future.

These changes fix up a number of false positives.

#### Array Safe Literals

In situations like

    ["hello", "there"].each do |s|
      something_with(s)
    end

Brakeman will replace `s` inside the block with `:BRAKEMAN_SAFE_LITERAL`, since the value must be a string (or `nil`, but Brakeman doesn't worrry about that).

`Array#map` and `Array#each` are currently supported.

#### Hash Access with Unknown Key

In code like

    some_hash = { x: 1, y: 2}
    result = some_hash[some_var]

Brakeman will replace `result` with `:BRAKEMAN_SAFE_LITERAL` since the value must be an integer.

([changes](https://github.com/presidentbeef/brakeman/pull/1227))

### Symbolized Keys in Params

Calls to `params.symbolize_keys` in ActiveRecord methods will not be treated as dangerous.

([changes](https://github.com/presidentbeef/brakeman/pull/1217))

### Conditionals in Shell Commands

Use of interpolated `if` expressions (or the ternary version) in shell commands is now handled better, thanks to [Jacob Evelyn](https://github.com/JacobEvelyn). The values of the branches will be checked for dangerous values before warning.

([changes](https://github.com/presidentbeef/brakeman/pull/1214))

### Update ERB Use for Ruby 2.6

The interface for ERB will be [updated in Ruby 2.6](https://github.com/ruby/ruby/blob/2311087/NEWS#stdlib-updates-outstanding-ones-only). [Koichi ITO](https://github.com/koic) provided a fix in preparation for this change.

([changes](https://github.com/presidentbeef/brakeman/pull/1220))

### Frozen Objects

Since the use of `freeze` is of little interest to Brakeman and obscures the object it is freezing, these calls are now ignored.

This, especially combined with the safe literals above, cleans up some false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/1230))

### Foreign Keys in SQL

Brakeman will now ignore calls to `foreign_key` in SQL strings.

([changes](https://github.com/presidentbeef/brakeman/pull/1229))

### Not `Module#included` Calls

Calls to `included` outside of modules/classes will be ignored instead of causing an error.

([changes](https://github.com/presidentbeef/brakeman/pull/1228))

### Checksums

The SHA256 sums for this release are:

    70722056ed1b168e2a56baff048fa155948e1d214513f0debe9e2b78f82691f8  brakeman-4.3.1.gem
    01078dd352a273965aa207dbffd01b8fe511d2302137f1984ea8bbddc38da3ce  brakeman-lib-4.3.1.gem
    1497a934e0fe929d4b2685a3282e7976ebd75e901c56183601b5c528ff4021e0  brakeman-min-4.3.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development (and get more features!), check out [Brakeman Pro](https://brakemanpro.com/).

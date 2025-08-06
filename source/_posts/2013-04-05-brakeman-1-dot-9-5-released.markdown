---
layout: blog
title: Brakeman 1.9.5 Released
date: 2013-04-05 08:42
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.9.4
  changes:
  - " * Add check for unsafe symbol creation ([Aaron Weiner](https://github.com/HonoreDB))"
  - " * Do not warn on mass assignment with `slice`/`only` ([#203](https://github.com/presidentbeef/brakeman/issues/203))"
  - " * Do not warn on session secret if in `.gitignore` ([#241](https://github.com/presidentbeef/brakeman/issues/241))"
  - " * Fix session secret check for Rails 4"
  - " * Fix scoping for blocks and block arguments"
  - " * Fix error when modifying blocks in templates"
  - " * Fix crash on `before_filter` outside controller"
  - " * Fix `Sexp` hash cache invalidation"
  - " * Respect `quiet` option in configuration file ([#300](https://github.com/presidentbeef/brakeman/issues/300))"
  - " * Convert assignment to simple `if` expressions to `or`"
  - " * More fixes for assignments inside branches"
  - " * Refactoring of `CheckLinkTo` and `Report` ([Bart ten Brinke](https://github.com/barttenbrinke))"
  - " * Pin ruby2ruby dependency to version 2.0.3 ([see here](https://github.com/seattlerb/ruby2ruby/issues/15))"
---


As planned, Brakeman 1.9.5 is mostly internal bug fixes and improvements, with the one exception being a new check for symbol creation from user input. Barring any emergencies, the next release will be 2.0.


## Symbol Creation Check

[Aaron Weiner](https://github.com/HonoreDB) added a check for symbol creation from user input, such as `params[:x].to_i` which can lead to Denial of Service.

([changes](https://github.com/presidentbeef/brakeman/pull/296))

## Mass Assignment with Select Keys

A common pattern to avoid mass assignment issues is to use `slice` or `only` when passing in values to mass assignment methods. Brakeman should no longer warn in these situations.

([changes](https://github.com/presidentbeef/brakeman/pull/303))

## Ignoring Session Secrets

Brakeman no longer warns if the config file containing the session secret key is included in `.gitignore`. This only applies if the default file names are used.

([changes](https://github.com/presidentbeef/brakeman/pull/302))

## Warn on Rails 4 Session Secrets

Support for Rails 4 session secrets has been added, since the configuration for that changed again.

([changes](https://github.com/presidentbeef/brakeman/pull/302))

## Block Scoping

Correct scope for blocks is tricky, and there are also some differences between Ruby 1.8 and 1.9 for block arguments. For the most part, Brakeman has ignored blocks, but this lead to some compounding issues with assignments in branches.

This release now treats all block arguments as local assignments *inside* the block and shadows any variables outside the block (this is Ruby 1.9 behavior). This should lead to some performance improvements where block arguments do shadow outer variables.

([changes and examples](https://github.com/presidentbeef/brakeman/pull/305))

## Sexp Hash Cache Invalidation

Since Brakeman does a ton of hash table lookups with s-expressions as keys, it caches `Sexp#hash` values. In some situations, these cached values were being invalidated when they did not need to be, and not being invalidated when they should have been.

([changes](https://github.com/presidentbeef/brakeman/pull/294))

## Quiet Option

Brakeman will now be quiet if the option is set in a configuration file.

([changes](https://github.com/presidentbeef/brakeman/pull/306))

## Assignments of If Expressions

Simple if expression assigments such as `x = thing ? this : that` will now be converted to `x = this || that`. This should simplify some code reported with warnings as well as avoid warning on values in `if` conditions.

([changes and examples](https://github.com/presidentbeef/brakeman/pull/295))

## Assignments in If Expressions

Assignments inside `if` branches cause Brakeman to "branch" the values for a variable, since it could be two or more different values. However, this branching should only occur *after* both branches have been processed. Brakeman 1.9.3 made it so values were not branched inside of a single branch, but there was still an issue where values branched in the `then` clause would be used in the `else` clause. This release fixes that issue and simplifies branching overall.

([changes and examples](https://github.com/presidentbeef/brakeman/pull/297))

## Refactoring Internals

[Bart ten Brinke](https://github.com/barttenbrinke) has begun some work refactoring some of the many ugly parts of Brakeman. Thanks!

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

## Roadmap

Next up should be [Brakeman 2.0](https://github.com/presidentbeef/brakeman/wiki/Roadmap) unless there needs to be another emergency release. Most of the changes for 2.0 are relatively minor, but break backwards compatibility in areas that may affect external tools. This includes cleaning up warning messages, removing duplicate information from JSON output, combining some checks, changing some defaults, and so on.

If you have suggestions for other breaking changes, please file an issue ASAP to get it into the next release!

---
layout: blog
title: Brakeman 2.6.3 Released
date: 2014-10-13 16:03
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 2.6.2
  changes:
  - " * Add framework for optional checks"
  - " * Add optional check for unscoped find queries ([Ben Toews](https://github.com/mastahyeti))"
  - " * Fix stack overflow for cycles in class ancestors ([Jeff Rafter](https://github.com/jeffrafter))"
  - " * Fix stack overflow in `ProcessHelper#class_name` ([#553](https://github.com/presidentbeef/brakeman/issues/553))"
  - " * Whitelist `exists` arel method from SQL injection check"
  - " * Avoid warning about Symbol DoS on safe parameters as method targets"
---


This is mostly a bug fix release, but does include new support for optional checks along with an optional check for unscoped calls to `find`.


## Optional Checks

Brakeman now supports loading checks that are not run by default. These "nondefault" checks may have high false positive rates or introduce significant slowdowns. Optional checks should be treated as experimental and may experience more breaking changes than default checks.

To run *all* checks, use `-A`. To list only the optional checks, try `--optional-checks`. Optional checks are also listed in `--checks`. As usual, checks may be specified using `-t` or `--test`. At this time there is no way to easily run the default checks plus some optional checks.

On the code side, optional checks are the same except `Brakeman::Checks.add self` becomes `Brakeman::Checks.add_optional self`.

([changes](https://github.com/presidentbeef/brakeman/pull/555))

## Unscoped Queries

The first optional check to be added to Brakeman comes from [Ben Toews](https://github.com/mastahyeti). This check looks for calls to `find` (or similar methods) directly on models that have a `belongs_to` relationship.

As this is an optional check, use `-A` to include it in a scan or `-t UnscopedFind` to run it by itself.

([changes](https://github.com/presidentbeef/brakeman/pull/469))

## Fix Loops in Class Ancestors

[Jeff Rafter](https://github.com/jeffrafter) added a fix for stack overflows (infinite loops) when a class has (or appears to have) a cycle in its superclasses.

([changes](https://github.com/presidentbeef/brakeman/pull/543))

## Fix Stack Overflow

This release fixes an issue with another infinite loop when looking up the class name in a self-referential variable name, which comes up in some situations. Fixing this bug also fixed some XSS false positives for safe model attribute methods (like `id`) but unfortunately also revealed some dynamic render false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/560))

## Whitelist Arel Method

Brakeman does not warn on most uses of Arel, but was warning about SQL injection from the `exists` method.

([changes](https://github.com/presidentbeef/brakeman/pull/566))

## Less Symbol DoS

Brakeman should no longer warn about Symbol DoS when symbolizing `params[:controller]` and `params[:action]` even when there are intermediate method calls, like `params[:action].to_s.to_sym`.

([changes](https://github.com/presidentbeef/brakeman/pull/564))

## SHAs

The SHA1 sums for this release are

    ceb689e3a6efd7e28483828de3441ec1fad501c1  brakeman-2.6.3.gem
    334a7820c05bfeb31e0e9d8123f45daef64eb102  brakeman-min-2.6.3.gem

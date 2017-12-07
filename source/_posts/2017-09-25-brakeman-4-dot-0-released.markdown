---
layout: post
title: "Brakeman 4.0 Released!"
date: 2017-09-25 06:31
comments: true
categories: 
---

**This release has breaking changes!**

This is the 101st official release of Brakeman! It has been seven years and one month since the first release of Brakeman.
To put that into historical context, Rails 3.0 was released a few days later! 

How about some more numbers?

* [7.6 million gem downloads](https://rubygems.org/gems/brakeman)
* 14,093 lines of Ruby code (excluding tests)
* [2,937 commits from 74 contributors](https://github.com/presidentbeef/brakeman/graphs/contributors)
* [385 issues closed](https://github.com/presidentbeef/brakeman/issues?q=is%3Aissue+is%3Aclosed)

Thank you so much to everyone who has used, contributed to, or promoted Brakeman over the past seven years!

As a token of our appreciation, we have a limited edition 2017 Brakeman sticker:

![Brakeman Sticker](/images/brakeman_anniversary_sticker.png)

Just email stickers@brakeman.org with your name and address (anywhere in the world) and we'll send you one. While supplies last!

<small>If you have benefited from Brakeman, please consider supporting continued development via [Brakeman Pro](https://brakemanpro.com).</small>

_Changes since 3.7.2_:

* `--exit-on-warn` is now the default ([#852](https://github.com/presidentbeef/brakeman/issues/852))
* `--exit-on-error` is now the default ([#1083](https://github.com/presidentbeef/brakeman/issues/1083))
* "Plain" report output is now the default
* Add simple pager for reports output to terminal
* Remove low confidence mass assignment warnings
* Reduce warnings about XSS in `link_to`
* Treat `request.cookies` like `cookies` ([#1090](https://github.com/presidentbeef/brakeman/issues/1090))
* Treat `fail`/`raise` like early returns ([#754](https://github.com/presidentbeef/brakeman/issues/754))
* Rename "Cross Site Scripting" to "Cross-Site Scripting" ([Paul Tetreau](https://github.com/paultetreau))
* Remove reliance on `CONFIDENCE` constant in checks
* Fix `--exit-on-error` and `--exit-on-warn` in config files

_Changes since 4.0.0_:

* Do not use pager when `CI` environment variable is set

### New Default Exit Codes

`--exit-on-warn` and `--exit-on-error` are now default behavior.

If any warnings are found or errors are raised during the scan, Brakeman's exit code will be non-zero. This may break things! In particular, CI jobs or scripts that assume Brakeman will exit normally.

You may use `--no-exit-on-warn` and `--no-exit-on-error` to revert back to previous behavior and always exit with error code 0.

([changes](https://github.com/presidentbeef/brakeman/pull/1085) and [changes](https://github.com/presidentbeef/brakeman/pull/1086))

### New Default Report Format

The "plain" report format is now the default.

To revert back to the table format, use `-f tables` or `-o report.tables`.

([changes](https://github.com/presidentbeef/brakeman/pull/1084))

### Paged Output

By default, output to the terminal will be paged with `less` or Highline's simple pager.

To disable, use `--no-pager`.

In 4.0.1 Brakeman will automatically disable the pager when the `CI` environment variable is set to `true`. This should be compatible with Travis CI, Circle CI, Codeship, and Bitbucket Pipelines.

([changes](https://github.com/presidentbeef/brakeman/pull/1098))

### Fewer Mass Assignment Warnings

Low confidence mass assignment warnings have been removed in this release. Brakeman should now only warn when user input is used directly in the instantiation or update of a model.

([changes](https://github.com/presidentbeef/brakeman/pull/1087))

### Fewer `link_to` Warnings

Warnings about XSS in `link_to` have confused quite a few people over the years. The danger is that links may have `javascript:` or `data:` values with XSS payloads.

Brakeman should now only warn when directly using user input or when using what looks like a URL from the database.

([changes](https://github.com/presidentbeef/brakeman/pull/1093))

### More Cookies

`request.cookies` will now be treated like cookies in general.

([changes](https://github.com/presidentbeef/brakeman/pull/1094))

### More Early Returns

Calls to `raise` or `fail` will be treated like early returns when considering simple guard expressions.

([changes](https://github.com/presidentbeef/brakeman/pull/1089)) 

### Cross-Site Scripting

Messages about "Cross Site Scripting" will now include a hyphen. This does not affect warning fingerprints.

([changes](https://github.com/presidentbeef/brakeman/pull/936))

### CONFIDENCE

Brakeman checks previously used the `CONFIDENCE` hash when creating warnings, e.g. `:confidence => CONFIDENCE[:high]`. Now it's possible to use `:confidence => :high` instead.

For those with custom checks, the `CONFIDENCE` hash is still available and nothing should break.

([changes](https://github.com/presidentbeef/brakeman/pull/1088))

### Checksums

The SHA256 sums for these releases are:

    0038932b43dcf2bf698ad6637500f69b5e4226b10c011a4a6bcce93a77a5e045  brakeman-4.0.0.gem
    3688303859a7c9b452ddcef00f00f97789ce103774446d42851a763ecbf8df87  brakeman-lib-4.0.0.gem
    559196c6e41e5b180448564d9aca84fb775a39b77dd7d8d880a0ce0e77df8ae2  brakeman-min-4.0.0.gem

    d93d6f8e9c2655520153fe0512b338753cc36fac56b80947f652fd33e9f80dfb  brakeman-4.0.1.gem
    82ab1e51f712ad10109a4fe080f6389b28bbbef83e0ecd6c33defa90319b4bc5  brakeman-lib-4.0.1.gem
    579f240cb8e5357fe5e45c09eb43f3512481f7086052337437e5c436c617da8b  brakeman-min-4.0.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development, check out [Brakeman Pro](https://brakemanpro.com/).

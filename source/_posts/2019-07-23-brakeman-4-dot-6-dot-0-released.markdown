---
layout: blog
title: Brakeman 4.6.0 Released
date: 2019-07-23 13:14
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.5.1
  changes:
  - Add check for cookie serialization with Marshal ([#1316](https://github.com/presidentbeef/brakeman/issues/1316))
  - Add reverse tabnabbing check ([Linos Giannopoulos](https://github.com/linosgian))
  - Avoid warning about file access with `ActiveStorage::Filename#sanitized` ([Tejas
    Bubane](https://github.com/tejasbubane))
  - Update loofah version for fixing [CVE-2018-8048](https://nvd.nist.gov/vuln/detail/CVE-2018-8048)
    ([Markus Nölle](https://github.com/MartyBeGood))
  - Warn people that Haml 5 is not fully supported ([Jared Beck](https://github.com/jaredbeck))
  - Index calls in initializers
  - Improve template output handling in conditional branches
  - Avoid assigning `nil` line numbers to `Sexp`s
  - Add special warning code for custom checks
  - Add call matching by regular expression
  - Skip calls to `dup` ([#1374](https://github.com/presidentbeef/brakeman/issues/1374))
  - Restore `Warning#relative_path`
  - Better handling of gems with no version declared
checksums:
- hash: 48be7f5a8d814ad42bbb9a2222a331e59a8ece9b50103d8e809a0bbc9d128ef9
  file: brakeman-4.6.0.gem
- hash: ff81f5d6fb258a1b83c78ba4144163d1183bd9f31536782722617e880ff85917
  file: brakeman-lib-4.6.0.gem
- hash: ef3ad0f59dc32630b1e39f289257cf33a882f2838f455e6009c0cb973ee1d378
  file: brakeman-min-4.6.0.gem
---


This release has two new checks!


## Cookie Serialization Check

Brakeman will now warn if `Rails.application.config.action_dispatch.cookies_serializer` is set to `:marshal` or `:json`.

This options allow cookies to be deserialized via `Marshal`. If an attacker is able to construct a valid encrypted cookie, this could lead to arbitrary code execution.

([changes](https://github.com/presidentbeef/brakeman/pull/1364))

## Reverse Tabnabbing Check

[Linos Giannopoulos](https://github.com/linosgian) has added an optional check for cases of "reverse tabnabbing". This occurs when a link is opened in a new window/tab via a link (with `target: '_blank'`).
The new window can control the location of the old window. If an attacker controls the new window, they can redirect the old window to a malicious site. This is especially useful for 
phishing attacks. These kinds of attacks are most likely on applications that allow arbitrary links to external sites.

To completely remove the ability of an attacker to control the old window, add `rel: "noreferrer noopener"` to the `link_to` call. Note: this will cause the new window to lose referrer information.

To enable this new check, use `--enable ReverseTabnabbing` or `-A` to enable all optional checks.

([changes](https://github.com/presidentbeef/brakeman/pull/1367))

## File Access False Positive

[Tejas Bubane](https://github.com/tejasbubane) provided a fix to ignore use of `ActiveStorage::Filename#sanitized` inside file access calls.

([changes](https://github.com/presidentbeef/brakeman/pull/1375))

## Fixed Loofah Version

[Markus Nölle](https://github.com/MartyBeGood) corrected the "fixed" version of Loofah for CVE-2018-8048 from `2.1.2` to `2.2.1`. Oops!

([changes](https://github.com/presidentbeef/brakeman/pull/1371))

## Haml 5 Support

[Jared Beck](https://github.com/jaredbeck) added a notification when Haml 5 is in use by an application. At the moment, Brakeman does not support Haml 5.x.
There appear to be only a few syntax differences between Haml 4.x and 5.x, so most users are unaffected.

Support is planned for a future release.

([changes](https://github.com/presidentbeef/brakeman/pull/1379))

## Initializers More Fully Supported

When Brakeman scans an application, [it "indexes" all method calls of interest](https://blog.presidentbeef.com/blog/2012/11/28/faster-call-indexing-in-brakeman-1-dot-8-3/). Most checks then operated on those indexed calls.

However, for historical reasons, initializers (files in `config/initializers/`) were not included in that index.

Now they are! Besides some modest speed gains and simpler/more consistent checks, now regular old checks can "see" initializers.
This may result in previously-unreported warnings now popping up in initializers.

([changes](https://github.com/presidentbeef/brakeman/pull/1363))

## Conditional Branches in Templates

Very obvious code like this:

```
<%= blah ? x : params[:x].html_safe %>
```

Was not being handled correctly and the cross-site scripting issue would not be reported. This is now fixed!

([changes](https://github.com/presidentbeef/brakeman/pull/1361))

## Empty Line Numbers

[A change in `sexp_processor`](https://github.com/seattlerb/sexp_processor/commit/ce284487f057203360c41b14d2b25f8c5453fbb9) causes it to raise an exception if an `Sexp` is assigned a `nil` line.
Brakeman was a bit cavalier when assigning line numbers, so this caused an issue for some users.

As a result, line numbers should be assigned a bit more consistently now.

([changes](https://github.com/presidentbeef/brakeman/pull/1360))

## Custom Check Warning Code

Every warning reported by Brakeman refers to an integer "warning code". This is so the "warning type" or category can be a bit more flexible if we want to change the name or formatting.
However, this list of warning codes is hardcoded into Brakeman. The hardcoding makes it hard for users to add their own checks, because they need to either use an existing code or monkey-patch in a new one. 

To help with this situation, custom checks/rules can now use the `:custom_check` warning code. 

[A tutorial on writing custom checks is in progress](https://github.com/presidentbeef/brakeman/wiki/Creating-Custom-Brakeman-Rules).

([changes](https://github.com/presidentbeef/brakeman/pull/1377))

## Call Matching via Regex

It is now possible to search for call targets by regular expression, although it is discouraged for performance reasons.

([changes](https://github.com/presidentbeef/brakeman/pull/1358))

## Dup Calls

Brakeman now skips calls to `#dup` as if they aren't there.

([changes](https://github.com/presidentbeef/brakeman/pull/1386))

## `Warning#relative_path`

`Warning#relative_path` has been added back for dependencies that might need it, such as [guard-brakeman](https://github.com/guard/guard-brakeman/pull/36/).

([changes](https://github.com/presidentbeef/brakeman/pull/1365))


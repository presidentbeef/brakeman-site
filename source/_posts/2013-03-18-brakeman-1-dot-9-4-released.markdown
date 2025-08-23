---
layout: blog
title: Brakeman 1.9.4 Released
date: 2013-03-18 17:07
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.9.3
  changes:
  - " * Add check for CVE-2013-1854"
  - " * Add check for CVE-2013-1855"
  - " * Add check for CVE-2013-1856"
  - " * Add check for CVE-2013-1857"
  - " * Fix `--compare` to work with older versions"
  - ' * Add "no-referrer" to HTML report links'
  - " * Don't warn when invoking `send` on user input"
  - " * Slightly faster cloning of Sexps"
  - " * Detect another way to add `strong_parameters` ([#288](https://github.com/presidentbeef/brakeman/issues/288))"
---


Another release forced out early due to Rails vulnerabilities reported today.


## Latest Reported Vulnerabilities

All CVE checks were included in [these changes](https://github.com/presidentbeef/brakeman/pull/290).

#### CVE-2013-1854 - Symbol Denial of Service

[CVE-2013-1854](https://groups.google.com/d/msg/rubyonrails-security/jgJ4cjjS8FE/BGbHRxnDRTIJ) is the creation of symbols when a hash is passed as the value to an ActiveRecord finder method.

Brakeman will warn on this CVE if there are any models using ActiveRecord and the Rails version is vulnerable.

#### CVE-2013-1855 - sanitize_css

[CVE-2013-1855](https://groups.google.com/d/msg/rubyonrails-security/4_QHo4BqnN8/_RrdfKk12I4J) is a vulnerability in the `sanitize_css` method.

Brakeman will warn on this CVE for each use of `sanitize_css` if the Rails version is vulnerable. Calls obviously sanitizing user input will be high confidence, other calls will be medium confidence.

#### CVE-2013-1856 - JRuby XML Parser

[CVE-2013-1856](https://groups.google.com/d/msg/rubyonrails-security/KZwsQbYsOiI/5kUV7dSCJGwJ) is a vulnerability in the default XML parser used when running Rails on JRuby.

Brakeman will warn on this CVE if run with JRuby and the Rails version is vulnerable. It will not warn if the provided workaround (not patch) is used in an initializers.

#### CVE-2013-1857 - sanitize

[CVE-2013-1857](https://groups.google.com/d/msg/rubyonrails-security/zAAU7vGTPvI/1vZDWXqBuXgJ) is a vulnerability in the `sanitize` method which allows URLs to include JavaScript.

Brakeman will warn on this CVE for each use of `sanitize` if the Rails version is vulnerable. Calls obviously sanitizing user input will be high confidence, other calls will be medium confidence.

## Fix JSON Compare

The 1.9.3 release introduced several new keys for warnings in the JSON output, which then broke `--compare` when used with output from an older version. Despite [declaring this would not be fixed](https://twitter.com/brakeman/status/307586866721460225), it has been fixed. `--compare` reverts to old behavior if a report is from an older version.

([changes](https://github.com/presidentbeef/brakeman/pull/284))

## Remove Referrer from HTML Report Links

All warning type links HTML reports now include the `rel="no-referrer"` option. This prevents referrer information from being passed along to the linked site (usually the [Brakeman site](http://brakemanscanner.org/)), which means people won't see that you are putting your Brakeman reports on the open internet...

([changes](https://github.com/presidentbeef/brakeman/pull/286))

## Fewer Dangerous Send Warnings

Now that Brakeman warns on dangerous uses of `constantize` and friends, there is no reason to warn on uses of `send`, `try`, etc. with user input as a target. User input for the method name will continue to warn.

For example, this will no longer generate a warning:

    params[:name].try(:downcase)

([changes](https://github.com/presidentbeef/brakeman/pull/285))

## Faster Sexp Cloning

Brakeman spends a lot of time cloning `Sexp`s, so this version introduces a slightly faster custom method instead of `Marshal.load(Marshal.dump(...))`.

([changes](https://github.com/presidentbeef/brakeman/pull/287))

## Another Strong Paramter Initializer

Brakeman now detects this approach to adding the `strong_parameters` functionality:

    ActiveRecord::Base.send(:include,  ActiveModel::ForbiddenAttributesProtection)

([changes](https://github.com/presidentbeef/brakeman/pull/289))

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

## Roadmap

This unexpected release means the roadmap has shifted again. The [roadmap](https://github.com/presidentbeef/brakeman/wiki/Roadmap) still has one more release (1.9.5) planned before 2.0. The next release will likely only include bug and false positive fixes. Again, Brakeman 2.0 will *definitely* include breaking changes, especially for JSON reports.

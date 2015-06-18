---
layout: post
title: "Brakeman 3.0.4 Released"
date: 2015-06-18 10:50
comments: true
categories: 
---

This is a small release prompted by Tuesday's CVE announcements. New checks for the CVEs directly in Rails have been added, and can also test for the suggested workarounds. Please consider using [bundler-audit](https://github.com/rubysec/bundler-audit) for detecting known vulnerable versions of gems, as Brakeman has only limited coverage.

Note this release also upgrades the RubyParser dependency. The latest RubyParser has several bug fixes and initial support for new Ruby 2.2 syntax.

*Changes since 3.0.3*:

* Add check for CVE-2015-3226 (XSS via JSON keys)
* Add check for CVE-2015-3227 (XML DoS)
* Treat `<%==` as unescaped output ([#661](https://github.com/presidentbeef/brakeman/issues/661))
* Update `ruby_parser` dependency to 3.7.0

### Cross Site Scripting in JSON

[CVE-2015-3226](https://groups.google.com/d/msg/rubyonrails-security/7VlB_pck3hU/3QZrGIaQW6cJ) is an issue with converting hashes to JSON. The keys do not properly escape HTML entities, leading to potential cross site scripting vulnerabilities. Brakeman will warn unless the workaround is included in an initializer (essentially verbatim). The warning is high confidence if there is evidence of explicitly converting values to JSON, otherwise medium.

([changes](https://github.com/presidentbeef/brakeman/pull/665))

### XML Denial of Service

[CVE-2015-3227](https://groups.google.com/d/msg/rubyonrails-security/bahr2JLnxvk/x4EocXnHPp8J) is a potential denial of service when parsing deeply nested XML requests. Brakeman will warn about this unless there is an initializer changing the XML parser as described in the CVE. Currently it looks for either `LibXML` or `Nokogiri`.

([changes](https://github.com/presidentbeef/brakeman/pull/666))

### Double Equals is Unescaped Output

Brakeman will now treat `<%== x %>` in ERB templates as unescaped output.

([changes](https://github.com/presidentbeef/brakeman/pull/663))

### SHAs

The SHA1 sums for this release are

    bf6ae72a0b516ecf65b9165d07e86259ef9fa5d3  brakeman-3.0.4.gem
    c1c2ea5402d8a89fe4a645947ec324d0603d3976  brakeman-min-3.0.4.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/). 


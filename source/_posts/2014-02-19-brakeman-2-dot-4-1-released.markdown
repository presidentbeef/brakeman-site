---
layout: post
title: "Brakeman 2.4.1 Released"
date: 2014-02-19 10:53
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release only adds checks for the latest CVEs, no other changes.

*Changes since 2.4.0*:

 * Add check for CVE-2014-0080
 * Add check for CVE-2014-0081, replaces CVE-2013-6415
 * Add check for CVE-2014-0082

### CVE-2014-0080

[CVE-2014-0080](https://groups.google.com/d/msg/rubyonrails-security/Wu96YkTUR6s/pPLBMZrlwvYJ) is a SQL injection issue only affects applications using PostgreSQL with Rails 4.x. If Brakeman detects the `pg` gem and an affected version, it will warn about this CVE.

([changes](https://github.com/presidentbeef/brakeman/pull/447))

### CVE-2014-0081

[CVE-2014-0081](https://groups.google.com/d/msg/rubyonrails-security/tfp6gZCtzr4/j8LUHmu7fIEJ) is a vulnerability in `number_to_currency`, `number_to_percentage`, and `number_to_human`. Values passed in as options may not be properly escaped. It affects all previous versions of Rails.

Brakeman will warn on unsafe uses of these methods. If no unsafe calls are found, it will generate a generic medium confidence warning.

Warnings for CVE-2014-0081 replace warnings for CVE-2013-6415, which was about just `number_to_currency`.

([changes](https://github.com/presidentbeef/brakeman/pull/448))

### CVE-2014-0082

[CVE-2014-0082](https://groups.google.com/d/msg/rubyonrails-security/LMxO_3_eCuc/ozGBEhKaJbIJ) is a potential symbol denial of service problem when handling `render :text` in Rails 3.x.

Brakeman will only warn about this CVE if it detects use of `render :text` in affected versions.

([changes](https://github.com/presidentbeef/brakeman/pull/449))

### SHAs

The SHA1 sums for this release are

    e9fb5439d5a322b4a9c9611d75d994e7df83d4d2  brakeman-2.4.1.gem
    b84ad90a7ec9b6e6bbce8fc69c50d1d8b3214d0f  brakeman-min-2.4.1.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter or joining the [mailing list](http://brakemanscanner.org/contact/). 


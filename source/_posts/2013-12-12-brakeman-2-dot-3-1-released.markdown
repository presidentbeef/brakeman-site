---
layout: blog
title: Brakeman 2.3.1 Released
date: 2013-12-12 23:24
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 2.3.0
  changes:
  - " * Fix check for CVE-2013-4491 (i18n XSS) to detect workaround"
  - " * Fix link for CVE-2013-6415 (number_to_currency)"
---


Two minor bugs were fixed in this release. Please see the [2.3.0 release post](http://brakemanscanner.org/blog/2013/12/11/brakeman-2-dot-3-0-released/) if you are upgrading from an earlier version.

([changes](https://github.com/presidentbeef/brakeman/pull/415))


## i18n XSS Workaround

Brakeman 2.3.0 included a check for the [official i18n XSS workaround](https://groups.google.com/d/msg/ruby-security-ann/pLrh6DUw998/bLFEyIO4k_EJ), but it was commented out during testing and unfortunately left that way.

## CVE-2013-6415 Link

The link provided for [CVE-2013-6415](https://groups.google.com/d/msg/ruby-security-ann/9WiRn2nhfq0/2K2KRB4LwCMJ) in Brakeman 2.3.0 was copy-pasted from an older check. This has been fixed.

## SHAs

The SHA sums for this release are

    469b209a4c72f5a1133d696575caeee1675837e7  brakeman-2.3.1.gem
    827e1cdefba543f59ed5070aaa3f587d8c7d9513  brakeman-min-2.3.1.gem

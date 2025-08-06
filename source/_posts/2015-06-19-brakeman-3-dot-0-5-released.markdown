---
layout: blog
title: Brakeman 3.0.5 Released
date: 2015-06-19 18:09
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 3.0.4
  changes:
  - Fix check for CVE-2015-3227 ([#667](https://github.com/presidentbeef/brakeman/issues/667))
---


And this is why you don't rush out releases.


## Fix CVE-2015-3227 Check

Includes information that Rails 3.2.22 is the fix version for anything before Rails 4.0. Fixes warning message when exact Rails version cannot be determined. Fixes link URL to point to the CVE announcement.

([changes](https://github.com/presidentbeef/brakeman/pull/668))

## SHAs

The SHA1 sums for this release are

    b78e11b745128ed7f9acd5d0c4f5e0e3a81f4d07  brakeman-min-3.0.5.gem
    c62cc782595d4995aa385b6bd96c2485ac932077  brakeman-3.0.5.gem

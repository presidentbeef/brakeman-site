---
layout: blog
title: Brakeman 4.2.1 Released
date: 2018-03-23 17:19
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.2.0
  changes:
  - Add warning for CVE-2018-3741
  - Add warning for CVE-2018-8048
  - Scan `app/jobs/` directory
  - Handle `template_exists?` in controllers ([#1124](https://github.com/presidentbeef/brakeman/issues/1124))
checksums:
- hash: 3ba1cd39d98edcae7a0802ef0206de1438439cfdf4edb559c676877e2c253498
  file: brakeman-4.2.1.gem
- hash: 54a4aa336f3c21477a9bab12eeba6bb79ffa34a015e89a748621f7fd037d1943
  file: brakeman-lib-4.2.1.gem
- hash: d53f2275320dfe5609234e74ce3a73a7d8c44dfae824fb938a9bae2077a9aecf
  file: brakeman-min-4.2.1.gem
---


This is a small release to add warnings for [CVE-2018-3741](https://groups.google.com/d/msg/rubyonrails-security/tP7W3kLc5u4/uDy2Br7xBgAJ) and [CVE-2018-8048](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ).

Please note there have been a number of vulnerabilities in the Rails HTML sanitization methods over the years. Only use sanitization when an application *must* accept and render HTML from an untrusted source. Otherwise, escape outputs instead.



## CVE-2018-3741

[CVE-2018-3741](https://groups.google.com/d/msg/rubyonrails-security/tP7W3kLc5u4/uDy2Br7xBgAJ) is a vulnerability in the `rails-html-sanitizer` gem which may allow bypassing attribute whitelists and therefore cross-site scripting.

([changes](https://github.com/presidentbeef/brakeman/pull/1171))

## CVE-2018-8048

[CVE-2018-8048](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ) is a similar vulnerability in the `loofah` gem.

([changes](https://github.com/presidentbeef/brakeman/pull/1169))

## Scan Jobs

Brakeman will now scan files in the `app/jobs/` directory and treat them as additional libraries.

([changes](https://github.com/presidentbeef/brakeman/pull/1168))

## Template Guard Condition

Brakeman will no longer warn about dynamic render paths if `template_exists?` is used as a guard condition.

([changes](https://github.com/presidentbeef/brakeman/pull/1170))

## A Note on Vulnerabilities in Depdendencies

Brakeman does not warn about *all* CVEs in application dependencies. There are many better tools that track and detect vulnerable dependencies.

Brakeman only includes warnings about vulnerabilities announced on the [Rails Security Mailing List](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ).


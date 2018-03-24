---
layout: post
title: "Brakeman 4.2.1 Released"
date: 2018-03-23 17:19
comments: true
categories: 
---

This is a small release to add warnings for [CVE-2018-3741](https://groups.google.com/d/msg/rubyonrails-security/tP7W3kLc5u4/uDy2Br7xBgAJ) and [CVE-2018-8048](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ).

Please note there have been a number of vulnerabilities in the Rails HTML sanitization methods over the years. Only use sanitization when an application *must* accept and render HTML from an untrusted source. Otherwise, escape outputs instead.

_Changes since 4.2.0_:

* Add warning for CVE-2018-3741
* Add warning for CVE-2018-8048
* Scan `app/jobs/` directory
* Handle `template_exists?` in controllers ([#1124](https://github.com/presidentbeef/brakeman/issues/1124))


### CVE-2018-3741

[CVE-2018-3741](https://groups.google.com/d/msg/rubyonrails-security/tP7W3kLc5u4/uDy2Br7xBgAJ) is a vulnerability in the `rails-html-sanitizer` gem which may allow bypassing attribute whitelists and therefore cross-site scripting.

([changes](https://github.com/presidentbeef/brakeman/pull/1171))

### CVE-2018-8048

[CVE-2018-8048](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ) is a similar vulnerability in the `loofah` gem.

([changes](https://github.com/presidentbeef/brakeman/pull/1169))

### Scan Jobs

Brakeman will now scan files in the `app/jobs/` directory and treat them as additional libraries.

([changes](https://github.com/presidentbeef/brakeman/pull/1168))

### Template Guard Condition

Brakeman will no longer warn about dynamic render paths if `template_exists?` is used as a guard condition.

([changes](https://github.com/presidentbeef/brakeman/pull/1170))

### A Note on Vulnerabilities in Depdendencies

Brakeman does not warn about *all* CVEs in application dependencies. There are many better tools that track and detect vulnerable dependencies.

Brakeman only includes warnings about vulnerabilities announced on the [Rails Security Mailing List](https://groups.google.com/d/msg/rubyonrails-security/b__OeLG9bts/waZTvSM2AQAJ).

### Checksums

The SHA256 sums for this release are:

    3ba1cd39d98edcae7a0802ef0206de1438439cfdf4edb559c676877e2c253498  brakeman-4.2.1.gem
    54a4aa336f3c21477a9bab12eeba6bb79ffa34a015e89a748621f7fd037d1943  brakeman-lib-4.2.1.gem
    d53f2275320dfe5609234e74ce3a73a7d8c44dfae824fb938a9bae2077a9aecf  brakeman-min-4.2.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development (and get more features!), check out [Brakeman Pro](https://brakemanpro.com/).

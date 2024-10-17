---
layout: post
title: "Brakeman 6.2.2 Released"
date: 2024-10-18 05:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Small release!

_Changes since 6.2.1:_

* Revamp command injection detection in `pipeline*` calls ([#1862](https://github.com/presidentbeef/brakeman/issues/1862))
* New end-of-support dates for Rails
* Exclude more native gems from vendored gems in `brakeman` gem ([#1869](https://github.com/presidentbeef/brakeman/issues/1869))

### Command Injection in `pipeline_*` calls 

More specific checks for arguments to `Open3` methods `pipeline`, `pipline_r`, `pipeline_rw`, `pipeline_w`, and `pipeline_start` to improve
both true and false positive rates.

([changes](https://github.com/presidentbeef/brakeman/pull/1868))

### Updated End of Support Dates for Rails 

Updated based on the [updated](https://rubyonrails.org/maintenance) [policy](https://rubyonrails.org/2024/10/15/new-maintenance-policy-and-eol-annouments).

Unfortunately, timing of this Brakeman release means Brakeman is already warning about Rails 6.1 end-of-support (ended October 1st).

([changes](https://github.com/presidentbeef/brakeman/pull/1843))

### Checksums

The SHA256 sums for this release are:

    f8892719490ed5f23e08fc14cb0020311a0af18fb47f7c7650345d0a35826413  brakeman-6.2.2.gem
    fb7ba15cd309f995c95d15d9e0e590f3aad6f95a5dfa030854e8806f3ba196d9  brakeman-lib-6.2.2.gem
    b3a5b59a14a527bfaca4d2637765e98c12ae800c8f044b1939da578d3ed31851  brakeman-min-6.2.2.gem


### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

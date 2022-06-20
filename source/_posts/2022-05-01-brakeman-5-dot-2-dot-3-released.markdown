---
layout: post
title: "Brakeman 5.2.3 Released"
date: 2022-05-01 08:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

_Changes since 5.2.2:_

* Fix error with hash shorthand syntax ([#1700](https://github.com/presidentbeef/brakeman/issues/1700))
* Match order of interactive options with help message ([Rory O'kane](https://github.com/roryokane))

### Hash Shorthand Syntax 

Parsing shorthand hash syntax like this was added with RubyParser 3.19:

```ruby
thing = 1

blah(thing:)
```

but Brakeman needed to handle it properly, too. 

([changes](https://github.com/presidentbeef/brakeman/pull/1701))

### Interative Options 

[Rory O'kane](https://github.com/roryokane) updated the ordering of options in the help message for interative ignore so
the help message matches the order of the options in the prompt!

([changes](https://github.com/presidentbeef/brakeman/pull/1702))

### Checksums

The SHA256 sums for this release are:

    5b6efb6a1e5c2b79063553647638e17239d2d2f4d50561230c8b0acaae4728d4  brakeman-5.2.3.gem
    3104abc8ac2b6558d9610ede40f4cac2ebc7ae45569876b8e5907b7422c4e3af  brakeman-lib-5.2.3.gem
    10d743c930c03ed1d2bea021ade8fac10f1229d02b8f65bf2214f7f09ec7a0ff  brakeman-min-5.2.3.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

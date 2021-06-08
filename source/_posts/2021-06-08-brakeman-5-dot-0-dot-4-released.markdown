---
layout: post
title: "Brakeman 5.0.4 Released"
date: 2021-06-08 11:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This is a tiny bugfix release!

_What happened to 5.0.2 and 5.0.3??_

5.0.2 was released with this fix, but did not include a pre-release `ruby_parser` fix for argument forwarding (`...`).

Then 5.0.3 was accidentally cut from the HEAD of the main branch, including a bunch of unrelated changes.

So 5.0.4 is the latest for the `brakeman` gem, 5.0.2 is the latest for `brakeman-min` and `brakeman-lib` since they do not bundle `ruby_parser`.

Clear as mud?

_Changes since 5.0.1:_

* Fix Loofah version check ([#1603](https://github.com/presidentbeef/brakeman/issues/1603))

### Checksums

The SHA256 sums for this release are:

    4d1af5c3e65a0c2319396a796bd9a587a13317faff92bd09b74c44ba70aef8b3  brakeman-5.0.4.gem
    01a49387dd347a47b6dcb0ec2de15f23f12257f22c27485e8380eed11be0b606  brakeman-lib-5.0.2.gem
    5f02c2c1de4faa288d8e035248a404ae21c49cdfd55dda01ce2cb579bba23bb9  brakeman-min-5.0.2.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

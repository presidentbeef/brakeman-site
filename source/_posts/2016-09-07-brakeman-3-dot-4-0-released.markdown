---
layout: post
title: "Brakeman 3.4.0 Released"
date: 2016-09-07 13:55
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Oops! Brakeman&#39;s 6th birthday was August 27th! 🎉 6 years, 61 contributors, 91 releases, 3.3 million gem downloads 🎉</p>&mdash; Brakeman Scanner (@brakeman) <a href="https://twitter.com/brakeman/status/772844048402964481">September 5, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

_Changes since 3.3.5_:

* Show obsolete ignore entries in reports ([Jonathan Cheatham](https://github.com/jcheatham))
* Add option to prune ignore file with `-I`
* Add new `plain` report format ([#914](https://github.com/presidentbeef/brakeman/issues/914))
* Support creating reports in non-existent paths ([#924](https://github.com/presidentbeef/brakeman/issues/924))
* Add `--no-exit-warn` ([#925](https://github.com/presidentbeef/brakeman/issues/925))
* Improved Slim template support

### Obsolete Ignore Entries

The "ignore" configuration file can sometimes grow large due to stale entries that no longer correspond to existing warnings. Thanks to [Jonathan Cheatham](https://github.com/jcheatham), these obsolete entires will now be noted in the default and JSON reports.

([changes](https://github.com/presidentbeef/brakeman/pull/894))

When using the `-I` option it is now possible to prune the ignore file.

![image](https://cloud.githubusercontent.com/assets/75613/18257206/f9631f9a-7374-11e6-92bc-94b9d3a635f4.png)

![image](https://cloud.githubusercontent.com/assets/75613/18257236/6868e726-7375-11e6-8a5b-30b6baed093a.png)

([changes](https://github.com/presidentbeef/brakeman/pull/934))

### New Report Format

This release adds a new "plain text" report format. It will eventually replace the default "table" report in Brakeman 4.0.

![image](https://cloud.githubusercontent.com/assets/75613/18259647/329a3da4-739b-11e6-8258-b7ab2073483b.png)

To output in the new format, use `-f plain` or `-o report.plain`.

The color codes should be disabled automatically if outputing to a file, but `--no-color` can be used to turn colors off.

Feedback on the new report format is encouraged prior to the 4.0 release.

([changes](https://github.com/presidentbeef/brakeman/pull/935))

### Report Paths

If the specified output file is in a non-existent path, Brakeman will now attempt to create the path before writing out the report.

([changes](https://github.com/presidentbeef/brakeman/pull/927))

### No Exit Code on Warnings

`--no-exit-warn` has been added to complement `--exit-warn`.

([changes](https://github.com/presidentbeef/brakeman/pull/926))

### Improved Slim Support

Most users will not notice any changes, but internally Slim templates are handled a bit better.

([changes](https://github.com/presidentbeef/brakeman/pull/932) and [more](https://github.com/presidentbeef/brakeman/pull/931))

### SHAs

The SHA256 sums for this release are

    0cfd4b9cb8515ed9cbd254710761bfc409c604f3351e200b22955a1c3f93f8d8  brakeman-3.4.0.gem
    7d07d87aa0732465bb6f0c17279f78edcfd0b1d841ddb63a95529ba762841395  brakeman-min-3.4.0.gem
    e3d61c1de5549984a0d9eb3a3a53a4ef17b1b41db1be7d504237dd05a0cfa203  brakeman-lib-3.4.0.gem

### Reporting Issues

Thank you to everyone who reported bugs.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


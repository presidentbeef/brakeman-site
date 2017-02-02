---
layout: post
title: "Brakeman 3.5.0 Released"
date: 2017-01-31 23:30
comments: true
categories: 
---

_Changes since 3.4.1_:

* Warn about SQL injection even if target is not known ActiveRecord model
* Avoid warning about models as SQL injection ([#655](https://github.com/presidentbeef/brakeman/issues/655), [#680](https://github.com/presidentbeef/brakeman/issues/680), [#833](https://github.com/presidentbeef/brakeman/issues/833))
* Avoid warning about SQLi in `all`, `first`, or `last` after Rails 4.0
* Treat templates without `.html` as HTML anyway ([#790](https://github.com/presidentbeef/brakeman/issues/790))
* Report check name in JSON and plain reports ([#971](https://github.com/presidentbeef/brakeman/issues/971))
* Add `--ensure-latest` option ([tamgrosser](https://github.com/tamgrosser) / [Michael Grosser](https://github.com/grosser))
* Add `--no-summary` to hide summaries in HTML/text reports ([#963](https://github.com/presidentbeef/brakeman/issues/963))
* Fail on invalid checks specified by `-x` or `-t` ([#970](https://github.com/presidentbeef/brakeman/issues/970))
* Handle `included` block in concerns ([#958](https://github.com/presidentbeef/brakeman/pull/958))
* Updated RubyParser/Ruby2Ruby dependencies


### SQL Injection Improvements

This release includes several changes to the SQL Injection check.

First, Brakeman will no longer restrict SQL injection warnings to calls on known ActiveRecord models. While this may lead to a few false positives, there were too many reports of obvious SQL injection being missed. This reverses a decision made previously. Warnings that may involve non-models are given a lower confidence.

Next, SQL that includes calls on model targets will no longer generate warnings. There were too many false positives and no known vulnerabilities flagged by this.

Finally, Brakeman will no longer check calls to `all`, `first`, and `last` as they changed in Rails 4.1.

([changes](https://github.com/presidentbeef/brakeman/pull/985))

### Extensionless Templates

Templates which do not specify any extension (e.g. just `.erb` instead of `.html.erb`) will still be treated as HTML instead of being ignored.

([changes](https://github.com/presidentbeef/brakeman/pull/980))

### Check Name in Reports

The plain and JSON reports now include the name of the check that generated the warning.

([changes](https://github.com/presidentbeef/brakeman/pull/981))

### Option to Enforce Latest Brakeman

The `--ensure-latest` option has been added. If there is a newer version of Brakeman available, this option will cause Brakeman to exit with a non-zero exit code.

([changes](https://github.com/presidentbeef/brakeman/pull/974))

### Option to Hide Summary

When using `--no-summary` and either the plain or "table" output, Brakeman will only report warnings, no metadata. Probably most useful in combination with `--quiet`.

([changes](https://github.com/presidentbeef/brakeman/pull/976))

### Fail on Invalid Checks

When use `-t` or `-x` to control which checks are run, Brakeman will now fail if the options supplied do not match existing check names. `-t None` may be used to avoid running any checks.

([changes](https://github.com/presidentbeef/brakeman/pull/986))

### Handle Included Concerns

Brakeman will now handle the `included` block in Concerns. Additionally, to support this, Concerns are processed prior to other classes.

([changes](https://github.com/presidentbeef/brakeman/pull/966))

### Checksums

The SHA256 sums for this release are:

    49fd8b3e6c1f348304bdbfc3b5d4cfbd465a5b5d4feec8337bbe3df7836787be  brakeman-3.5.0.gem
    2ef50a61ca4aa1cff1f28dfe6308ea53157d996975519f5ae5c9266bf5772fb0  brakeman-min-3.5.0.gem
    766c9da778e3be36ca709e637276f090514dbc0ddde5e261a1baff6da351480e  brakeman-lib-3.5.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

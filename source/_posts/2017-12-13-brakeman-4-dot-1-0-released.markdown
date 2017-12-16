---
layout: post
title: "Brakeman 4.1.0 Released"
date: 2017-12-12 18:01
comments: true
categories: 
---

Wow, it has been *too* long since the last release!

Happy December!

_Changes since 4.0.1:_

* Add check for dangerous keys in `permit`
* Add optional check for divide by zero
* Remove errors about divide by zero
* Warn about dynamic values in `Arel.sql`
* Show better location for Sass errors ([Andrew Bromwich](https://github.com/abrom))
* Avoid warning about file access for temp files ([#1110](https://github.com/presidentbeef/brakeman/issues/1110))
* Avoid CSRF warning in Rails 5.2 default config ([#1132](https://github.com/presidentbeef/brakeman/issues/1132))
* Better processing of `op_asgn1` (e.g. `x[:y] += 1`) ([#1103](https://github.com/presidentbeef/brakeman/issues/1103))
* Handle nested destructuring/multiple assignment
* Do not warn on `params.permit` with safe values ([#1000](https://github.com/presidentbeef/brakeman/issues/1000))
* Use HTTPS for warning links
* Try to guess options for `less` pager ([#1118](https://github.com/presidentbeef/brakeman/issues/1118))
* Do not page if results fit on screen
* Leave results on screen after paging
* Fix upgrade version for CVE-2016-6316
* Fix `include_paths` for Code Climate engine ([Will Fleming](https://github.com/wfleming))
* Support `app_path` configuration for Code Climate engine ([Noah Davis](https://github.com/noahd1))
* Refactor Code Climate engine options parsing ([Noah Davis](https://github.com/noahd1))

### New Check for Dangerous Permit Keys

Very similar to warning about potentially dangerous keys in `attr_accessible`, Brakeman now warns about potentially dangerous keys whitelisted for mass assignment via `params.permit`.

([changes](https://github.com/presidentbeef/brakeman/pull/1128))

### New Optional Check for Division by Zero

Previously, Brakeman would report errors when it encountered potential division by zero. Now, it optionally reports warnings instead.

([changes](https://github.com/presidentbeef/brakeman/pull/1122))

### Arel.sql

`Arel.sql` allows one to add raw SQL to queries. Brakeman now warns about potential SQL injection when using `Arel.sql` with dynamic values.

([changes](https://github.com/presidentbeef/brakeman/pull/1129))

### Sass Error Locations

Thanks to [Andrew](https://github.com/abrom), Brakeman now reports actual file names for errors involving Sass.

([changes](https://github.com/presidentbeef/brakeman/pull/1133))

### Temp Files

Brakeman no longer warns about file access with `params[:blah].tempfile.path` or `params[:blah].path`.

([changes](https://github.com/presidentbeef/brakeman/pull/1121))

### Rails 5.2 CSRF Configuration

In Rails 5.2, CSRF protection is enabled by default. Brakeman will now respect this.

([changes](https://github.com/presidentbeef/brakeman/pull/1138))

### Attribute Combination Assignment

This release handles code like `x[:y] += 1` better. Previously, it would not update the value for `x[:y]`.

([changes](https://github.com/presidentbeef/brakeman/pull/1123))

### Nested Destructuring

Brakeman now can handle nested multiple assignment, like `x, (a, b), y = z`, assuming `z` is known to be an array.

([changes](https://github.com/presidentbeef/brakeman/pull/1113))

### Pager Updates

The default pager (`less`) now leaves the output in the terminal after exiting and now exits immediately if the output fits on the screen.

Additionally, Brakeman attempts to detect if these options are actually supported by `less` before using them.

([changes](https://github.com/presidentbeef/brakeman/pull/1112) and [here](https://github.com/presidentbeef/brakeman/pull/1120))

### CVE-2016-6316

In case this one was keeping you up at night, Brakeman now reports the correct upgrade version for CVE-2016-6316.

([changes](https://github.com/presidentbeef/brakeman/pull/1105))

### HTTPS for Warning Links

Links to brakemanscanner.org in reports are now HTTPS! Only makes sense.

([changes](https://github.com/presidentbeef/brakeman/pull/1114))

### Code Climate Updates

The Brakeman engine on [Code Climate](https://docs.codeclimate.com/docs/brakeman) now supports `app_path` and `include_paths`, together.

([changes](https://github.com/presidentbeef/brakeman/pull/1126))

### Checksums

The SHA256 sums for this release are:

    1dd62ee8aa872acf5d0aace6dc0745b55c78da68640f04754bf11c12a58842bf  brakeman-4.1.0.gem
    a16bd3082223655f132ff4c601f5d1930290082116fc256c5c1e652ff3ba933a  brakeman-lib-4.1.0.gem
    29d9be77b06195675e6b803141da979438983c0970c182fe8b8ccf3145ecda9f  brakeman-min-4.1.0.gem


### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development (and get more features!), check out [Brakeman Pro](https://brakemanpro.com/).

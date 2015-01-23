---
layout: post
title: "Brakeman 3.0.0 Released"
date: 2015-01-02 17:09
comments: true
categories: 
---

This is a major version release of Brakeman which introduces some backwards-incompatible changes. Very likely this release will cause many changes in reports, including fingerprints on existing warnings.

_Changes since 2.6.3_:

* `--exit-on-warn --compare` only returns error code on new warnings ([Jeff Yip](https://github.com/jeffyip))
* Sort warnings by fingerprint in JSON report ([Jeff Yip](https://github.com/jeffyip))
* CVEs report correct line and file name (Gemfile/Gemfile.lock) ([Rob Fletcher](https://github.com/pwnetrationguru))
* Change `--separate-models` to be the default
* Local variables are no longer formatted as `(local var)`
* Actually skip skipped before filters
* Remove "fake filters" from warning fingerpints
* Index calls in `lib/` files
* Handle symmetric multiple assignment
* Do not branch for self attribute assignment `x = x.y` ([#552](https://github.com/presidentbeef/brakeman/issues/552))
* Move Symbol DoS to optional checks
* Add check for cross site scripting via inline renders
* Add check for CVE-2014-7829
* Fix parsing of `<%==` in ERB
* Fix output format of command interpolation
* Fix CVE for CVE-2011-2932

### Exit Code When Comparing

When using `--exit-on-warn --compare`, Brakeman will only return a non-zero exit code when there are new warnings. Previous behavior was to return non-zero exit code if there were any differences between reports (including fixed warnings).

([changes](https://github.com/presidentbeef/brakeman/pull/588))

### Sort Warnings in JSON Report

Warnings are now sorted by their fingerprint in the JSON report to provide more stable output.

([changes](https://github.com/presidentbeef/brakeman/pull/587))

### Report Line Numbers for CVEs

Previously, CVE warnings typically pointed to `Gemfile` with no line number information. Now CVEs should point to `Gemfile` or `Gemfile.lock` as appropriate and include the line number for the vulnerable gem dependency.

([changes](https://github.com/presidentbeef/brakeman/pull/557) and [more changes](https://github.com/presidentbeef/brakeman/pull/569))

### Mass Assignment Warnings Default to per Model

The `--separate-models` option is now on by default. This means warnings about missing `attr_accessible` will be reported for each model instead of rolling them into a single warning.

([changes](https://github.com/presidentbeef/brakeman/pull/586))

### Local Variable Format

Local variables are no longer formatted as `(local var)` in warning output.

([changes](https://github.com/presidentbeef/brakeman/pull/594))

### Skip Skipped Filters

Before filters which are skipped are now actually skipped during data flow analysis.

([changes](https://github.com/presidentbeef/brakeman/pull/592))

### Fake Filter Change

Before filters defined as blocks (instead of methods) are internally represented as methods with random names prepended by `fake_filter`. Since the method names were not stable, any warnings inside the filters would have inconsistent fingerprints. Now warnings inside of before filters will always be reported with `before_filter` as the method name.

([changes](https://github.com/presidentbeef/brakeman/pull/572))

### Index Calls in Libraries

Classes defined in `lib/` files will now be included in the method call index and searched for vulnerabilities. As these files were already being processed, this has not added any significant overhead in testing.

([changes](https://github.com/presidentbeef/brakeman/pull/571))

### Handle Multiple Assignment

Simple symmetric multiple assignments (also called "parallel assignment") like `x, y = 1, 2` are now handled like normal assignments.

([changes](https://github.com/presidentbeef/brakeman/pull/577))

### Avoid Branching on Self Assignment

Brakeman no longer creates new union values for self assignment of attributes.

([changes](https://github.com/presidentbeef/brakeman/pull/578))

### Symbol DoS is an Optional Check

In this release the check for denial of service via symbol creation has been changed to an optional check. Memory exhaustion by creating lots of new symbols is an unlikely attack and easily mitigated by having at least two web servers. Additionally

([changes](https://github.com/presidentbeef/brakeman/pull/570))

### Warn on Inline XSS 

Unescaped user input in `render :text` or `render :inline` should now generate warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/598))

### CVE-2014-7829

Brakeman will warn about [CVE-2014-7829](https://groups.google.com/d/msg/rubyonrails-security/23fiuwb1NBA/MQVM1-5GkPMJ) (file existence disclosure) for applications using affected versions of Rails and setting `config.serve_static_assets = true`.

([changes](https://github.com/presidentbeef/brakeman/pull/600))

### ERB Parsing Fix

Parsing `<%==` in ERB templates no longer causes errors.

([changes](https://github.com/presidentbeef/brakeman/pull/589))

### Command Interpolation Format Fix

Brakeman was formatting

    `#{x}`

as

    `x`

This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/596))

### CVE-2011-2932

The ancient CVE-2011-2932 was being mis-reported as CVE-2011-2931. Hopefully this affects no one.

([changes](https://github.com/presidentbeef/brakeman/pull/575))

### Certificate Update

The certificate used to sign the Brakeman gem expired in December. A new certificate is available [here](https://raw.githubusercontent.com/presidentbeef/brakeman/master/brakeman-public_cert.pem).

This command can be used to add the new certificate:

    gem cert --add <(curl -Ls https://raw.github.com/presidentbeef/brakeman/master/brakeman-public_cert.pem)

### SHAs

The SHA1 sums for this release are

    4180238f8de503e7ad0f2ca952ea38ccc1c6530b  brakeman-3.0.0.gem
    b5cefd6f14edb57f12d1fe9fcc0fb24e05a05aaf  brakeman-min-3.0.0.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/). 

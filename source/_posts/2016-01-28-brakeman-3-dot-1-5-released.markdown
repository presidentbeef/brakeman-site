---
layout: post
title: "Brakeman 3.1.5 Released"
date: 2016-01-28 08:26
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release adds warnings for the latest Rails CVEs.

*Changes since 3.1.4*:

* Warn about RCE with `render params` (CVE-2016-0752)
* Add check for `strip_tags` XSS (CVE-2015-7579)
* Add check for `sanitize` XSS (CVE-2015-7578/80)
* Add check for basic auth timing attack (CVE-2015-7576)
* Add check for `reject_if` proc bypass (CVE-2015-7577)
* Add check for denial of service via routes (CVE-2015-7581)
* Add check for mime-type denial of service (CVE-2016-0751)
* Check for implicit integer comparison in dynamic finders
* Support directories better with `--only-files` and `--skip-files` ([Patrick Toomey](https://github.com/ptoomey3))
* Fix CodeClimate construction of `--only-files` ([Will Fleming](https://github.com/wfleming))
* Avoid warning about `permit` in SQL ([669](https://github.com/presidentbeef/brakeman/issues/669))
* Avoid warning on user input in comparisons
* Handle guards using `detect` ([376](https://github.com/presidentbeef/brakeman/issues/376))
* Handle module names with self methods ([#785](https://github.com/presidentbeef/brakeman/issues/785))
* Add session manipulation documentation ([#791](https://github.com/presidentbeef/brakeman/pull/791))
* Add initial Rails 5 support

### Render Remote Code Execution

First up, [CVE-2016-0752](https://groups.google.com/d/msg/rubyonrails-security/335P1DcLG00/OfB9_LhbFQAJ) allows an attacker to render files outside of the application path as well as [execute arbitrary code](https://nvisium.com/blog/2016/01/26/rails-dynamic-render-to-rce-cve-2016-0752/). Passing in `params` values directly is [especially dangerous](https://twitter.com/joernchen/status/456822118500823040). Brakeman has warned about passing user input to `render` since it was first released as "dynamic render path" warnings. For calls to `render` that directly pass in `params`, it has been changed to a remote code execution warning in affected versions.

([changes](https://github.com/presidentbeef/brakeman/pull/807))

### Sanitization XSS

[CVE-2015-7579](https://groups.google.com/d/msg/rubyonrails-security/OU9ugTZcbjc/PjEP46pbFQAJ), [CVE-2015-7578](https://github.com/presidentbeef/brakeman/pull/807), and [CVE-2015-7580](https://groups.google.com/d/msg/rubyonrails-security/uh--W4TDwmI/m_CVZtdbFQAJ) are vulnerabilities in `rails-html-sanitizer` affecting the `strip_tags` and `sanitize` methods. Brakeman will mark uses of `strip_tags` and `sanitize` with `raw` or `html_safe` as high confidence warnings. Since these methods might be used in support gems, Brakeman will also generate a generic warning for the CVEs in apps using vulnerable versions of `rails-html-sanitizer`..

([changes](https://github.com/presidentbeef/brakeman/pull/805) plus [these](https://github.com/presidentbeef/brakeman/pull/806))

### Basic Auth Timing Attack

The implementation of `http_basic_authenticate_with` did not use constant-time comparison when checking passwords, allowing timing attacks as described in [CVE-2015-7576](https://groups.google.com/d/msg/rubyonrails-security/ANv0HDHEC3k/mt7wNGxbFQAJ). Brakeman will warn about affected applications using `http_basic_authenticate_with`.

([changes](https://github.com/presidentbeef/brakeman/pull/800))

### Bypass Record Deletion Filtering

[CVE-2015-7577](https://groups.google.com/d/msg/rubyonrails-security/cawsWcQ6c8g/tegZtYdbFQAJ) is a bug where the `reject_if` option to `accepts_nested_attributes_for` will not be called if `allow_destroy` is set to `false`. Brakeman will warn on applications which meet all of these criteria and do not include the workaround in an initializer.

([changes](https://github.com/presidentbeef/brakeman/pull/804))

### Wildcard Route Denial of Service

Brakeman will warn about [CVE-2015-7581](https://groups.google.com/d/msg/rubyonrails-security/dthJ5wL69JE/YzPnFelbFQAJ) when it detects routes containing `':controller'` wildcards on affected versions of Rails. These routes can be abused to cause a denial of service.

([changes](https://github.com/presidentbeef/brakeman/pull/808))

### Mime-type Denial of Service

Sending many different mime-types via `Accept` headers can cause a denial of service. Brakeman will warn about [CVE-2016-0751](https://groups.google.com/d/msg/rubyonrails-security/9oLY_FCzvoc/w9oI9XxbFQAJ) in affected versions of Rails unless the workaround is present.

([changes](https://github.com/presidentbeef/brakeman/pull/801))

### MySQL Implicit Integer Conversion

As [described here](http://www.phenoelit.org/blog/archives/2013/02/05/mysql_madness_and_rails/), MySQL will convert string values to match integer input - often leading to `0=0` comparisons in queries which will always return true. Brakeman will warn when an application uses MySQL and `find_by_*` dynamic finders on potentially sensitive fields like `password`.

([changes](https://github.com/presidentbeef/brakeman/pull/798))

### Better Directory Support When Skipping Files

[Patrick Toomey](https://github.com/ptoomey3) provided a patch to better explicitly match directories with `--only-files` and `--skip-files`. See the [updated options](https://github.com/presidentbeef/brakeman/blob/82de21d7c85acd8980ae7c4b86d77207f73b3444/OPTIONS.md#scanning-options) for details.

*Please note use of `--only-files` is strongly discouraged. Brakeman is designed to scan entire applications.*

([changes](https://github.com/presidentbeef/brakeman/pull/764))

### CodeClimate File Restriction 

The `include_paths` configuration for the CodeClimate engine has been updated by [Will Fleming](https://github.com/wfleming) to handle spaces and other special characters.

([changes](https://github.com/presidentbeef/brakeman/pull/803/))

### Permit `permit` in SQL

Surprisingly, it is safe and effective to use `params.permit` in SQL queries, as it will always return a hash of values which will be interpreted as parameterized values. Brakeman will no longer warn about uses of `permit` in SQL queries.

([changes](https://github.com/presidentbeef/brakeman/pull/795))

### User Input in Comparisons

Brakeman will no longer warn about user input in comparisons, such as `'x' == params[:x]`.

([changes](https://github.com/presidentbeef/brakeman/pull/793))

### Detect `detect` Guard Statements

Fixing a [bug](https://github.com/presidentbeef/brakeman/issues/376) filed almost 2.5 years ago, Brakeman will now recognize `Array#detect`/`Array#find` being used to whitelist values.

For example:

    if safe_name = [:A, :B, :C].detect { |v| v == params[:v] }
      safe_name.constantize
    end

([changes](https://github.com/presidentbeef/brakeman/pull/794/))

### Self Methods with Modules

Definitions of self methods inside nested modules was broken and is now fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/792))

### Session Manipulation Documentation

Documentation for session manipulation warnings has now been added to [the Brakeman site](http://brakemanscanner.org/docs/warning_types/session_manipulation/) and for the CodeClimate engine.

([changes](https://github.com/presidentbeef/brakeman/pull/791))

### Rails 5 Support

Initial support for Rails 5 has been added to Brakeman, including a `-5` option to force Rails 5 mode. However, no special analysis or warnings specific to Rails 5 have been implemented yet.

([changes](https://github.com/presidentbeef/brakeman/pull/799))

### CVE-2016-0753?

This release does not include a warning for [CVE-2016-0753](https://groups.google.com/d/msg/rubyonrails-security/6jQVC1geukQ/8oYETcxbFQAJ). The vulnerability appears to require using `permit!` which Brakeman already warns about, or else passing in hashes that are not query parameters which Brakeman would not be able to detect as dangerous or benign.

### SHAs

The SHA256 sums for this release are

    fa9528859d4baa8cd4fbe67f634cd3741ee85d553bf59c4b2315a5ccb2976835  brakeman-3.1.5.gem
    3248084efe71fcbb0c65b36e71ff0c06e65ac6bce1817a6f9d38ae0657a95bde  brakeman-min-3.1.5.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed improvements in this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter or hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman). Please note the mailing list is no longer in use and has apparently not been delivering mail for some time.

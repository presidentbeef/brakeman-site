---
layout: post
title: "Brakeman 1.7.0 Released"
date: 2012-07-31 17:44
comments: true
categories: 
---

This release includes improvements to Rails 3 route processing, better performance, several bug fixes, and more!

_Changes since 1.6.2_:

 * Add check for CVE-2012-3424
 * Link report types to descriptions on website
 * Report errors raised while running check
 * Improve processing of Rails 3 routes
 * Improve file access check
 * Avoid warning on non-ActiveModel models
 * Fix how `params[:x] ||=` is handled
 * Treat user input in `or` expressions as immediate values
 * Fix processing of negative array indexes
 * Fix "empty char-class" error
 * Speed improvements by stripping down SexpProcessor
 * Add line breaks to truncated table rows

### Check for HTTP Auth Digest DoS

[CVE-2012-3424](https://groups.google.com/d/topic/rubyonrails-security/vxJjrc15qYM/discussion), a potential denial of service vulnerability in how Rails handles HTTP authentication digest parameters, was recently announced. It affects Rails 3.x, and is fixed in 3.0.16, 3.1.7, and 3.2.7.

Brakeman will generate a warning for the Rails versions affected, but will only report a high confidence warning if `authenticate_or_request_with_http_digest` or `authenticate_with_http_digest` methods are called.

### Links to Warning Information

HTML reports now link warning types to descriptions on the Brakeman website. JSON reports will also include the link information. Due to this change, it is not possible to compare JSON reports from previous versions using the `--compare` option.

Suggestions and [pull requests](https://github.com/presidentbeef/brakeman-site) for improving the documention are welcome!

### Report Check Errors

Previously, errors encounted while running checks were not included in reports. This has been fixed.

### Better Rails 3 Route Processing

Even the simple information Brakeman uses (which methods are routes) is difficult to extract from Rails 3 routes due to all the different options it offers. This release should decrease the number of "Error while processing routes" messages that come up.

See [this pull request](https://github.com/presidentbeef/brakeman/pull/116) for more information about specific fixes.

### Improved File Access Check

The check for user input in file access calls has been improved so the confidence of the warnings will vary according to how the user input is used, like most other checks.

Additionally, the check will now respect the `--report-direct` option.

### No SQLi Warnings for Non-ActiveModel

Models which do not inherit from `ActiveRecord::Base` will no longer be reported in SQL injection warnings.

### Default Assignment to `params`

Normally, when Brakeman processes an assignment like `x ||= y`, it will assign `y` to `x` if no previous value is found for `x`.

However, in this case:

    params[:x] ||= y

The information that the left hand side is a `params` hash is lost.

This has been changed so default assignment to a `params` hash will not replace the entire value, but will handle it as `params[:x] || y`. 

### User Input in `or` Expressions

Previously, unescaped output like

    <%= params[:x] || z %>

would have been reported as a weak confidence warning. This has been changed so that any user input in an `or` expression will be considered immediate (versus "indirect") output and will likely result in high confidence warnings.

### Speed Improvements

Scan times should decrease by 15-25% with this release. This is mostly due to stripping unused bits out of SexpProcessor.

### Bug Fixes

Besides errors raised when processing Rails 3 routes, the `Result must be a Sexp, was Symbol::array` and `empty char-class` errors should be resolved now.

Please report any errors raised when performing scans, as they are usually bugs.

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter. 

---
layout: post
title: "Brakeman 5.4.1 Released"
date: 2023-02-21 08:30
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Several changes in this release are updates to Brakeman's open redirect check.

_Changes since 5.4.0:_

* Add Rails 6.1 and 7.0 default configuration values
* Support Rails 7 redirect options
* Add `redirect_back` and `redirect_back_or_to` to open redirect check
* Revise checking for `request.env` to only consider request headers
* Prevent redirects using `url_from` being marked as unsafe ([Lachlan Sylvester](https://github.com/lsylvester))
* Warn about unscoped find for `find_by(id: ...)`
* Support `presence`, `presence_in` and `in?` ([#1569](https://github.com/presidentbeef/brakeman/issues/1569))
* Fix issue with `if` expressions in `when` clauses ([#1743](https://github.com/presidentbeef/brakeman/issues/1743))
* Fix file/line location for EOL software warnings

### Rails 6.1 and Rails 7.0 Defaults

The default configuration values for Rails 6.1 and Rails 7.0 have been added to Brakeman.

([changes](https://github.com/presidentbeef/brakeman/pull/1751))

### Open Redirect Updates

Rails 7 introduced a new protection against open directs.

If `config.action_controller.raise_on_open_redirects` is set to `true`, then Rails prevents redirects that redirect to a different domain than `request.host`.
This protection can be bypassed by passing in `allow_other_host: true` to `redirect_to`.

([changes](https://github.com/presidentbeef/brakeman/pull/1755))

[Lachlan Sylvester](https://github.com/lsylvester) pointed out it's also possible to use `url_from` to ensure a URL is for the same host. So `redirect_to(url_from(params[:url]))` is safe.

([changes](https://github.com/presidentbeef/brakeman/pull/1749))

This release also expands the open redirect check to `redirect_back` and `redirect_back_or_to` which have options for a fallback URL.

([changes](https://github.com/presidentbeef/brakeman/pull/1756))

### More Unscoped Finds 

Brakeman will now warn about use of `find_by(id: ...)` the same way it would warn about `find_by_id` for "unscoped finds" (i.e., possible insecure direct object references).

([changes](https://github.com/presidentbeef/brakeman/pull/1748))

### Presence Method Support

Brakeman now handles `presence`, `presence_in`, and `in?` methods.

Since `presence_in` and `in?` are often used for guard clauses, this fixes some false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/1747))

### File/Line for End-Of-Life Warnings

March is nearly here, which means support for Ruby 2.7 is ending!

Thanks to [Jon Burns](https://github.com/jburns42891) for pointing out Brakeman was reporting the wrong file and/or line number for EOL Ruby warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/1761))

### Checksums

The SHA256 sums for this release are:

    dc664d4b5d01dd81608db02ec9b7c383beb65a3169049df2939c4bbbd4edfb73  brakeman-5.4.1.gem
    c1bf7e4cec5bde1d53122b41743343d3e38e4aa30145707b902278dd3b588fd4  brakeman-lib-5.4.1.gem
    94d24f3ea881bfc213ead8fbf3568aa37b301272ccbecf383394c9d7d7f43eeb  brakeman-min-5.4.1.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

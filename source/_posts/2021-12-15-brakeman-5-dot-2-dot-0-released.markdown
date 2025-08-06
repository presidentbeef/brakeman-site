---
layout: blog
title: Brakeman 5.2.0 Released
date: 2021-12-15 11:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 5.1.2
  changes:
  - Initial Rails 7 support ([#1653](https://github.com/presidentbeef/brakeman/issues/1653))
  - Add new checks for unsupported Ruby and Rails version
  - Fix issue with calls to `foo.root` in routes ([#1640](https://github.com/presidentbeef/brakeman/issues/1640))
  - Ignore `I18n.locale` in SQL queries ([#1597](https://github.com/presidentbeef/brakeman/issues/1597))
  - Do not treat `sanitize_sql_like` as safe
  - Bundled version of `ruby_parser` updated to 3.18.1
  - Require Ruby 2.5.0+ ([#1649](https://github.com/presidentbeef/brakeman/issues/1649))
---



## Initial Rails 7 Support

Nothing special here, but the `-7` option is available and Brakeman won't think a Rails 7 app is a Rails 2 app.

([changes](https://github.com/presidentbeef/brakeman/pull/1654))

## New Checks for Unmaintained Software

Brakeman will now warn about use of Ruby or Rails versions which are no longer maintained.

Unlike other warnings, these new checks have a time component and _will_ change as the end-of-life dates approach:

* 60 days until EOL: Low warning
* 30 days until EOL: Medium warning
* EOL+: High warning

([changes](https://github.com/presidentbeef/brakeman/pull/1660))

## Bug Fix in Routes

Calls to `something.root` will no longer cause Brakeman to freak out.

([changes](https://github.com/presidentbeef/brakeman/pull/1655))

## SQL Injection Updates

`I18n.locale` is ignored in SQL queries.

([changes](https://github.com/presidentbeef/brakeman/pull/1658))

`sanitize_sql_like` is no longer treated as "safe". It only escapes `LIKE`-specific characters such as `%` but does not prevent SQL injection.

([changes](https://github.com/presidentbeef/brakeman/pull/1657))

---
layout: post
title: "Brakeman 5.0.0 Released"
date: 2021-01-26 12:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

It has been a long time coming, but it is finally here! Lots of changes in this one...

Brakeman now scans (almost) all Ruby (and ERB, Haml, Slim) files in an application.
This may have a significant impact on reported warnings and scan times - see below for more information.

_Changes since 4.10.1:_

* Scan (almost) all Ruby files in project
* Revamp CSV report to a CSV list of warnings
* Add Sonarqube report format ([Adam England](https://github.com/adamnengland))
* Add check for (more) unsafe method reflection ([#1488](https://github.com/presidentbeef/brakeman/issues/1488), [#1507](https://github.com/presidentbeef/brakeman/issues/1507), and [#1508](https://github.com/presidentbeef/brakeman/issues/1508))
* Add check for potential HTTP verb confusion ([#1432](https://github.com/presidentbeef/brakeman/issues/1432))
* Add `--[no-]skip-vendor` option
* Ignore `uuid` as a safe attribute
* Ignore `Tempfile#path` in shell commands
* Ignore development environment
* Collapse `__send__` calls
* Set Rails configuration defaults based on `load_defaults` version
* Update Ruby requirement to version 2.4.0
* Suggest using `--force` if no Rails application is detected

### Scan Almost All Ruby Files 

Since the beginning, Brakeman has been picky about what directories it searches for files.
In general, Brakeman has looked in 'normal' Rails directores like `app/controllers/`, `app/models/`, `app/views/`, `lib/`, `config`, etc.
This is because Rails has some default logic based on file paths - like mapping a controller action to a given view.

But if an application varied from the norm, Brakeman would simply not scan those other directories.
This behavior led to a lot of confusion with folks wondering why Brakeman was not finding certain vulnerabilities.

Brakeman now attempts to deduce the contents of a file first, then falls back to the path name if necessary.
This has been surprisingly effective.

However, scanning more files means Brakeman runs slower and may report more false positives because the new files
are harder to reason about and less likely to be exposed as part of the attack surface.

Brakeman does ignore `test`, `spec`, and `vendor` directories. To scan the `vendor` directory as well, use `--no-skip-vendor`.

Please report any issues!

([changes](https://github.com/presidentbeef/brakeman/pull/1520))

### CSV Report Update 

The CSV report format has been completely changed! Previously, it was meant as an 'Excel-lite' format, only really useful for viewing in a spreadsheet program.

Now it is regular CSV with normalized columns to mostly match the JSON report (except for nested fields). 

([changes](https://github.com/presidentbeef/brakeman/pull/1547))

### Sonarqube Report Format

Thanks to [Adam England](https://github.com/adamnengland), Brakeman now supports the Sonarqube "[Generic Issue Import Format](https://docs.sonarqube.org/latest/analysis/generic-issue/)". 

(And thanks Adam for your patience.)

([changes](https://github.com/presidentbeef/brakeman/pull/1505))

### More Unsafe Method Reflection

A new check was added for unsafe use of `method`, `to_proc`, and `tap`.

([changes](https://github.com/presidentbeef/brakeman/pull/1527))

### HTTP Verb Confusion Check

In Rails, `HEAD` requests are routed like `GET` requests, but `request.get?` will be false.

Some code may assume if `request.get?` is false, then `request.post?` is true:

```ruby
if request.get?
  # Do something benign
else
  # Do something sensitive because it's a POST
  # but actually it could be a HEAD :(
end
```

Brakeman will warn when an `if` expression checks `request.get?` but has an `else` clause instead of `elseif ...`.

([changes](https://github.com/presidentbeef/brakeman/pull/1524))

### UUIDs as Safe Attributes

`#uuid` will be treated as a safe value, particular in SQL.

([changes](https://github.com/presidentbeef/brakeman/pull/1553))

### Tempfile Paths in Shell Commands

`Tempfile#path` will be considered as safe value for command injection.

Also adds support for Tempfiles like:

```ruby
Tempfile.open('...') do |file|
  # Brakeman knows `file` is a Tempfile
end
```

([changes](https://github.com/presidentbeef/brakeman/pull/1544)

### Ignore Development Environment

Brakeman will ignore code that is guarded like

```ruby
if Rails.env.development?
  # ...whatever code
end
```

This was already true for `Rails.env.test?`.

([changes](https://github.com/presidentbeef/brakeman/pull/1549))

### Collapse `__send__` Calls

Brakeman will treat

```ruby
Blah.__send__(:something, 5.0)
```

as

```ruby
Blah.something(5.0)
```

This was already true for `send` and `try`.

([changes](https://github.com/presidentbeef/brakeman/pull/1551))

### Set Rails Defaults

Brakeman will set default values for Rails configuration options based on the version argument to `config.load_defaults` which is usually called in `application.rb`.

([changes](https://github.com/presidentbeef/brakeman/pull/1532))

### Requires Ruby 2.4.0

The minimal Ruby version for running Brakeman is now 2.4.0 (which is already EOL!)

Note Brakeman can analyze Ruby syntax from 1.8 to 2.6 (some 2.7+ syntax is not supported yet).

([changes](https://github.com/presidentbeef/brakeman/pull/1515))

### Checksums

The SHA256 sums for this release are:

    21b91f67cde4cf487df0a4dbf6e54729064c665bb0b4b370b71bac9435b63e4c  brakeman-5.0.0.gem
    3641c52448ca1d12423595ca1a874c1362f438cd58196825be648bb797096cb5  brakeman-lib-5.0.0.gem
    50bab26fe8fcf8d962baaf5b08b7c178315b7c0e4be07d1b134e8ae00338c908  brakeman-min-5.0.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


---
layout: post
title: "Brakeman 5.1.0 Released"
date: 2021-07-19 10:50
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This is a _huge_ release! (So many changes, I had to look up how to nest lists in Markdown...)

Thank you to the many contributors!

There are several new features, take a look below.

_Changes since 5.0.4:_

* Report Formats
  * Add GitHub Actions format ([Klaus Badelt](https://github.com/klausbadelt))
  * Add ignored warnings to SARIF report ([Eli Block](https://github.com/eliblock))
  * Fix SARIF report when checks have no description ([Eli Block](https://github.com/eliblock))
  * Adjust copy of `--interactive` menu ([Elia Schito](https://github.com/elia))
* Performance
  * Read and parse files in parallel
* Ruby Interpretation  
  * Initial support for ActiveRecord enums ([#1492](https://github.com/presidentbeef/brakeman/issues/1492))
  * Interprocedural dataflow from very simple class methods
  * Support `Array#fetch` and `Hash#fetch` ([#1571](https://github.com/presidentbeef/brakeman/issues/1571))
  * Support `Array#push`
  * Support `Array#*`
  * Better `Array#join` support
  * Support `Hash#values` and `Hash#values_at`
  * Support `Hash#include?`
* SQL Injection
  * Update SQL injection check for Rails 6.0/6.1
  * Add `--sql-safe-methods` option ([Esty Scheiner](https://github.com/escheiner))
  * Ignore dates in SQL
  * Ignore `sanitize_sql_like` in SQL ([#1571](https://github.com/presidentbeef/brakeman/issues/1571))
  * Ignore method calls on numbers in SQL ([#1571](https://github.com/presidentbeef/brakeman/issues/1571))
* Other Fixes
  * Ignore renderables in dynamic render path check ([Brad Parker](https://github.com/bradparker))
  * Fix false positive in command injection with `Open3.capture` ([Richard Fitzgerald](https://github.com/xulaus))
  * Fix infinite loop on mixin self-includes ([Andrew Szczepanski](https://github.com/Skipants))
  * Check for user-controlled evaluation even if it's a call target ([#1590](https://github.com/presidentbeef/brakeman/issues/1590))
* Refactoring
  * Refactor `cookie?`/`param?` methods ([Keenan Brock](https://github.com/kbrock))
  * Better method definition tracking and lookup

## Report Formats

[Klaus Badelt](https://github.com/klausbadelt) added support for GitHub Actions annotation format with `-f github`.

([changes](https://github.com/presidentbeef/brakeman/pull/1580))

[Eli Block](https://github.com/eliblock) added support for reporting ignored warnings in SARIF using the "suppressed" property and fixed a SARIF bug.

([changes](https://github.com/presidentbeef/brakeman/pull/1620))

[Elia Schito](https://github.com/elia) clarified some text in the `--interactive` menu for ignoring warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/1598))

## Parallel File Parsing

Brakeman now uses the [`parallel`](https://rubygems.org/gems/parallel) gem to read and parse files in parallel.

By default, `parallel` will split the reading/parsing into a number of separate processes based on
number of CPUs.

In testing, this has dramatically improved speed for large code bases - around 35% reduction in overall scan time.

However, if you run into weird behavior (e.g. scanning just hangs during file parsing), this feature
can be disabled using `--no-threads`.

([changes](https://github.com/presidentbeef/brakeman/pull/1617))

## Ruby Interpretation

### Simple Class Methods

Brakeman will now track and return _very simple_ literal values (e.g. strings, hashes of literals, arrays of literals) from _very simple_ class methods (e.g. single line).

For example:

```ruby
class User
  def self.path_prefix
    '/user'
  end
end

User.path_prefix # => '/user'
```

This should help prevent some false positives.

### Enums

Since [ActiveRecord enums](https://api.rubyonrails.org/v6.1.4/classes/ActiveRecord/Enum.html) essentially generate some class (and instance) methods that return fixed literal values, the above class method return values
is also used to support `enum`.

For example:
```ruby
class User < ActiveRecord::Base
  enum status: [:pending, :active, :locked]
end

User.statuses[:pending] # => 0
```

([changes](https://github.com/presidentbeef/brakeman/pull/1572))

### Hash and Array Methods

In some ways, Brakeman is a very poor Ruby interpreter.
To "understand" the code it analyzes, Brakeman essentially evaluates some methods.
This release adds and improves support for evaluating a number of `Hash` and `Array` methods.

* Support `Array#fetch` and `Hash#fetch`
([changes](https://github.com/presidentbeef/brakeman/pull/1589))

* Support `Array#push`
([changes](https://github.com/presidentbeef/brakeman/pull/1600))

* Support `Array#*` and improve `Array#join`
([changes](https://github.com/presidentbeef/brakeman/pull/1599))

* Support `Hash#values` and `Hash#values_at`
([changes](https://github.com/presidentbeef/brakeman/pull/1595))

* Support `Hash#include?`
([changes](https://github.com/presidentbeef/brakeman/pull/1618/commits/3554a2c7f259b3a96dc69877c9596c81190eed8d))

## SQL Injection


### Updates for Rails 6.0/6.1

Some new Rails 6.0 methods were previously added for SQL injection (`destroy_by`/`delete_by`), but this release is more thorough.

Newly vulnerable methods:

* `reselect`
* `rewhere`

No longer vulnerable:

* `delete_all`
* `destroy_all`
* `pluck` (in Rails 6.1)

Not _really_ vulnerable:

* `order` (in Rails 6.1)
* `reorder` (in Rails 6.1)

(Also, https://rails-sqli.org/ has also been updated with Rails 6 information!)

([changes](https://github.com/presidentbeef/brakeman/pull/1619))

### Safe Methods

[Esty Scheiner](https://github.com/escheiner) added the `--sql-safe-methods` option to ignore some methods when checking for SQL injection.

([changes](https://github.com/presidentbeef/brakeman/pull/1601))

### False Positives

Brakeman no longer warns about SQL injection for:

* Dates and methods called on dates
([changes](https://github.com/presidentbeef/brakeman/pull/1615))

* Method calls on number literals
([changes](https://github.com/presidentbeef/brakeman/pull/1586))

* `sanitize_sql_like`
([changes](https://github.com/presidentbeef/brakeman/pull/1587))

## Misc Fixes

[Brad Parker](https://github.com/bradparker) updated the dynamic render path check to ignore "renderables".

([changes](https://github.com/presidentbeef/brakeman/issues/1529))

[Richard Fitzgerald](https://github.com/xulaus) fixed a command injection false positive when using `Open3.capture`.

([changes](https://github.com/presidentbeef/brakeman/pull/1612))

[Andrew Szczepanski](https://github.com/Skipants) fixed an infinite loop when a mixin appears to include itself.

([changes](https://github.com/presidentbeef/brakeman/pull/1611))

Brakeman will now warn about user-controlled evaluation even if the evaluation is a call target itself.

For example:
```ruby
eval(params[:debug]).do_something_else
```

([changes](https://github.com/presidentbeef/brakeman/pull/1592))

## Refactoring

[Keenan Brock](https://github.com/kbrock) cleaned up the `cookie?`/`param?` utility methods.

([changes](https://github.com/presidentbeef/brakeman/pull/1608))

In support of `enum` and simple class methods, Brakeman now has a cleaner way of tracking and looking up method definitions.

([changes](https://github.com/presidentbeef/brakeman/pull/1596))

## New and Updated Options

`--sql-safe-methods` can be used to specify methods that should be ignored in the context of SQL injection.

`--format github`/`-f github` will output code the annotation format used by GitHub Actions.

`--no-threads`/`-n` will disable use of threads (actually forked processes) for reading and parsing files.
(Previously, this method only disabled use of threads when running checks.)

### Checksums

The SHA256 sums for this release are:

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

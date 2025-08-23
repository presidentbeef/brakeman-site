---
layout: blog
title: Brakeman 1.2 Released
date: 2012-01-13 22:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: '1.1'
  changes:
  - " * Speed improvements for CheckExecute and CheckRender"
  - " * Check `named_scope` and `scope` for SQL injection"
  - " * Add `--rake` option to create rake task to run Brakeman"
  - " * Add `--summary` option to only output summary"
  - " * Add experimental support for rescanning a subset of files"
  - " * Fix a problem with Rails 3 routes"
---


First Brakeman release of 2012!


Besides those, there has also been quite a bit of code improvement internally.

## Speed Improvements

The checks for command injection and dynamic render paths should be considerably faster now.

## More SQL Injection Checks

Thanks to [a5sk4s](https://github.com/presidentbeef/brakeman/issues/30) for pointing out that Brakeman was not checking `named_scope` for SQL injection. This has been rectified. For Rails 3.1 and up, `scope` will be checked.

Also, it seems common to use `Model.table_name` inside SQL statements. This will no longer raise a warning.

## Brakeman Rake Task

The `--rake` option can now be used to install a Rake task for running Brakeman. The task will be copied to `lib/tasks/brakeman.rake`.

To use, run this from the root of the Rails app:

    brakeman --rake

Then, to run Brakeman:

    rake brakeman:run

Naturally, this requires Rake to be installed.

To output to a specific file:

    rake brakeman:run["report.html"]

More actions may be added in the future.

## Summary Option

Sometimes the specifics of a scan are not needed. The `--summary` option will limit the report output to just the summary section.

## Rescan for Subset of Files

This release adds experimental support for rescanning a subset of paths in a Rails application. Please see this [example](https://gist.github.com/1563286).

## Issues

Please report _any_ problems or questions on [GitHub](https://github.com/presidentbeef/brakeman/issues) or send a tweet to [@Brakeman](https://twitter.com/#!/brakemanscanner)!

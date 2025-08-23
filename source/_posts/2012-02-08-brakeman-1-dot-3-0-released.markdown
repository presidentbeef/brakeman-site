---
layout: blog
title: Brakeman 1.3.0 Released
date: 2012-02-08 15:11
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.2.2
  changes:
  - " * Add file paths to HTML report"
  - " * Add caching of filters"
  - " * Add `--skip-files` option"
  - " * Add support for `attr_protected`"
  - " * Add detection of request.env as user input"
  - " * Descriptions of checks in `-k` output"
  - " * Improved processing of named scopes"
  - " * Check for mass assignment in `ActiveRecord::Associations::AssociationCollection#build`"
  - " * Better variable substitution"
  - " * Table output option for rescan reports"
---


Thanks to everyone who reported problems and suggestions this time around!

This release includes some new features, better performance on large projects, and more detection criteria. Warnings reported may change after upgrading.


## File Paths in HTML Report

In the HTML output, any warning which has context associated with it (visible when clicking on the warning message) will now include the file name at the top of the code snippet.

## Filter Caching

Filters (using `before_filter`) are now only parsed once, instead of for everytime they are used. This has greatly improved performance when scanning some large projects.

## Option to Skip Files

A list of files to skip can be provided with the `--skip-files` option. This will skip any initializers, libraries, controllers, models, or views that match the file names provided. The file names to skip are matched against the end of the absolute path. That is, `blah.rb` will skip *any* file with a name ending in `blah.rb`. This means it is not necessary to provide the full path to a file.

## Support for Blacklisting Attributes

Previously, Brakeman ignored uses of `attr_protected`. Ideally, `attr_accessible` should always be used to whitelist attributes that can be set using mass assignment. This way, attributes can never be "accidentally" exposed. However, it can also be tedious for large models.

With this release, Brakeman will downgrade mass assignment warnings to "weak" confidence if `attr_protected` is used, as well as suggesting that `attr_accessible` be used instead.

The `--ignore-protected` option can be used to suppress any warnings for models that use `attr_protected`.

## Request Environment is User Input

`request.env` will now be treated as user input.

## Check Descriptions

The `-k` option now includes descriptions of each check.

## Named Scope Improvements

The 1.2.0 release added checking for SQL injection in named scopes, but it was not very accurate. This has been improved.

## Better Variable Substitution

Variable substitution would sometimes "explode" if a set of code was processed for aliasing several times.

For example,

    x = clean(x)

    puts x

Might become

    x = clean(x)

    puts clean(clean(clean(clean(x))))

This should now be prevented, so it would just become

    x = clean(x)

    puts clean(x)

There may be subtle issues with this code (although I have not seen any yet), but it's better than creating a bunch of useless substitutions.

## Table Output for Rescan Reports

`RescanReport#to_s(true)` will now output formatted tables, thanks to [Dave Worth](https://github.com/presidentbeef/brakeman/pull/33).

## Issues?

As usual, please report any issues on [GitHub](https://github.com/presidentbeef/brakeman/issues), send a tweet to [@Brakeman](https://twitter.com/brakeman), or send an email to the [mailing list](http://librelist.com/browser/brakeman/).

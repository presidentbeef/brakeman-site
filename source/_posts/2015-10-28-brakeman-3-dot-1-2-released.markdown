---
layout: blog
title: Brakeman 3.1.2 Released
date: 2015-10-28 15:59
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 3.1.1
  changes:
  - Sortable tables in HTML report (David Lanner)
  - Add line numbers to class-level warnings
  - Warn on SQL query keys, not values in hashes ([#738](https://github.com/presidentbeef/brakeman/issues/738))
  - Set user input value for inline renders
  - Avoid warning on inline renders with safe content types
  - Treat `current_user` like a model ([#744](https://github.com/presidentbeef/brakeman/issues/744))
  - Avoid warning about model `find/find_by*` in hrefs
  - Handle `private def ...`
  - Handle empty interpolation in HAML filters ([#732](https://github.com/presidentbeef/brakeman/issues/732))
  - Catch divide-by-zero in alias processing ([#729](https://github.com/presidentbeef/brakeman/issues/729))
  - Ignore filters that are not method names
  - Search for config file relative to application root
  - Use SafeYAML to load configuration files
  - Allow inspection of recursive Sexps
  - Reduce string allocations in `Warning#initialize`
---


This release is mostly bug fixes and false positive reduction. However, please note fingerprints for inline render warnings will change.


## Sortable Tables

[David Lanner](https://github.com/dlanner) added the ability to sort tables in the HTML report by clicking on the column headers.

([changes](https://github.com/presidentbeef/brakeman/pull/726))

## Line Numbers for Class Warnings

When warning about an entire class (like a model missing `attr_accessible`), the warning line number will point to the beginning of the class. 

([changes](https://github.com/presidentbeef/brakeman/pull/733))

## SQL Query Hashes

A long-standing bug in Brakeman caused it to warn about values in query hashes (e.g., `User.where(:x => params[:x])`) when it was intended to warn about user input in the _keys_.

([changes](https://github.com/presidentbeef/brakeman/pull/740)) 

## Inline Renders

Brakeman will now report the `render` call as the `code` value and the user input as `user_input`. Please note the code will look a little different from what Brakeman reports, as render calls are turned into a slightly different AST node internally. This will definitely change fingerprints for these warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/751))

## current\_user

In a couple places, Brakeman will treat `current_user` like a model instance, which it almost always is. This will probably be expanded in future releases.

([changes](https://github.com/presidentbeef/brakeman/pull/749))

## Inline Privates

Calls to `private` using the return value of `def` will now work properly:

    private def secret_stuff
    # ...
    end

([changes](https://github.com/presidentbeef/brakeman/pull/731))

## Empty HAML Interpolation

Empty HAML interpolation inside of filters will no longer cause crashes and will be handled properly.

([changes](https://github.com/presidentbeef/brakeman/pull/750))

## Divide-by-Zero

Brakeman sometimes divides by zero when it performs simple arithmetic during constant folding. While this is now reported as an error (and used to be, too), someday it should be a warning instead.

([changes](https://github.com/presidentbeef/brakeman/pull/730))

## Config File Changes

When looking for the `config/brakeman.yml` configuration file, Brakeman will now look relative to the application path instead of the working directory.

Additionally, the `SafeYAML` gem is used to prevent code execution for those running Brakeman against untrusted code.

(changes [here](https://github.com/presidentbeef/brakeman/pull/725) and [here](https://github.com/presidentbeef/brakeman/pull/741))

## SHAs

The SHA256 sums for this release are

    c01f07ccc2490d0421e5974499c57f519aa371bfab5d25ba3b224e7ae9e2c415  brakeman-3.1.2.gem
    d820c872cbe7bc8452c9bd8bd46d990ff1c0d53ee621c09f1997270fc978f783  brakeman-min-3.1.2.gem

---
layout: post
title: "Brakeman 3.3.0 Released"
date: 2016-05-05 09:49
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Brakeman 3.3.0 introduces a new packaging method for Brakeman which vendors all dependencies and does not include any gem dependencies in the gemspec. Please test and provide feedback if it does not work as expected.

*Changes since 3.2.1*:

* Bundle all dependencies in gem
* Return exit code `4` if no Rails application is detected ([#869](https://github.com/presidentbeef/brakeman/issues/869))
* Add optional check for secrets in source code ([#201](https://github.com/presidentbeef/brakeman/issues/201))
* Track constants globally
* Skip if branches with `Rails.env.test?` ([#862](https://github.com/presidentbeef/brakeman/issues/862))
* Skip processing obviously false if branches (more broadly)
* Handle HAML `find_and_preserve` with a block ([#837](https://github.com/presidentbeef/brakeman/issues/837))
* Process `Array#first`
* Allow non-Hash arguments in `protect_from_forgery` ([Jason Yeo](https://github.com/jsyeo))
* Avoid warning about `u` helper ([Chad Dollins](https://github.com/cdollins))
* Avoid warning about mass assignment and SQL injection with `params.slice` ([#866](https://github.com/presidentbeef/brakeman/issues/866))
* Avoid warning about `slice` in `redirect_to` and `link_to` ([#832](https://github.com/presidentbeef/brakeman/issues/832))
* Avoid warning on `popen` with array ([#851](https://github.com/presidentbeef/brakeman/issues/851))
* [Code Climate engine] When possible, output to /dev/stdout ([Gordon Diggs](https://github.com/GordonDiggs))
* [Code Climate engine] Remove nil entries from `include_paths` ([Gordon Diggs](https://github.com/GordonDiggs))
* [Code Climate engine] Report end lines for issues ([Gordon Diggs](https://github.com/GordonDiggs))

### Dependency Bundling

In its gem form, Brakeman no longer declares any external dependencies. Its dependencies are bundled with the gem itself. This should prevent the conflicts which sometimes occur when Brakeman is declared as a dependency of a Rails application. The disadvantage is you will no longer be able to update Brakeman dependencies (like RubyParser) without updating Brakeman itself.

As this is a new way of distributing Brakeman, please report any issues that may arise.

([changes](https://github.com/presidentbeef/brakeman/pull/845))

### New Exit Code

A new exit code has been added for the case when Brakeman does not detect a Rails application.

For reference, these are Brakeman's current exit codes:

* `0` - Normal exit
- `3` - Warnings found (with `-z`)
- `4` - No Rails application detected
* `255` - Error

([changes](https://github.com/presidentbeef/brakeman/pull/870))

### Secrets Check

A new optional check has been added to look for hard-coded secrets in the source code. It will warn when constants like `PASSWORD` are assigned string literals. To run the new check, use `-t Secrets` or `-A` to run all checks including optional ones.

([changes](https://github.com/presidentbeef/brakeman/pull/861))

### Constant Values

This release includes initial support for tracking and matching constants across the application. For example, if a model contains a constant `Model::KEYS` which is used elsewhere, Brakeman should be able to track this value. This helps prevents false positives when safe values have been declared as constants.

([changes](https://github.com/presidentbeef/brakeman/pull/855))

### Skipping Test Code

Brakeman will now ignore `if` branches that check `Rails.env.test?`. Additionally, branch skipping behavior (e.g. `if false...`) has been expanded to most of Brakeman's processing instead of just in data flow analysis.

([changes](https://github.com/presidentbeef/brakeman/pull/868))

### HAML `find_and_preserve`

Brakeman will now handle uses of `find_and_preserve` in HAML with a block.

([changes](https://github.com/presidentbeef/brakeman/pull/839))

### Array#first

Calls to `Array#first` will be replaced with the first value in the array when known.

([changes](https://github.com/presidentbeef/brakeman/pull/856))

### Forgery Option

[Jason Yeo](https://github.com/jsyeo) provided a fix for when Brakeman encounters a non-Hash argument to `protect_from_forgery`.

([changes](https://github.com/presidentbeef/brakeman/pull/849))

### `u` Helper

[Chad Dollins](https://github.com/cdollins) fixed XSS false positives when the `u` alias for `url_encode` is used.

([changes](https://github.com/presidentbeef/brakeman/pull/863))

### Fewer `slice` False Positives

Brakeman should no longer warn when using `params.slice` in mass assignment, SQL injection, links, and open redirects.

([changes](https://github.com/presidentbeef/brakeman/pull/867) and [other changes](https://github.com/presidentbeef/brakeman/pull/871))

### Safe popen

Brakeman will no longer warn about uses of `popen` when the argument is an array, in which case the arguments are escaped.

([changes](https://github.com/presidentbeef/brakeman/pull/854))

### Code Climate Engine

[Gordon Diggs](https://github.com/GordonDiggs) provided several improvements to the Code Climate Engine in this release:

* Remove `nil` entries from the `include_paths` option
* Force output to stdout when possible
* Report end lines to conform with spec

### SHAs

The SHA256 sums for this release are

    c01ec64d35218887fc5ea2ae8babc88e9e0e7cc3c161b020725d2b17c4189858  brakeman-3.3.0.gem
    f1adce1a696799342dc9f50b51975024060360dc9018358c5d8e34c1c4681bd1  brakeman-min-3.3.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed improvements in this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and hanging out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion. Please note the mailing list is no longer in use and has apparently not been delivering mail for some time.

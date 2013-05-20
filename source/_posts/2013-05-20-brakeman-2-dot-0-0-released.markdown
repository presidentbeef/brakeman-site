---
layout: post
title: "Brakeman 2.0.0 Released"
date: 2013-05-20 10:09
comments: true
categories: 
---

Brakeman 2.0 is here! While it does include a lot of updates, the "2.0" is mostly to indicate this release includes some changes which may break external tools (also, who wants a version "1.10"?). Tool maintainers are encouraged to avoid dependencies on warning messages and types (use the "warning code" instead), and to use warning fingerprints + line numbers for comparing warnings.

Lots more features are on the horizon for the 2.x family!

_Changes since 1.9.5_:

 * Remove "timestamp" key from JSON reports
 * Relative paths are used by default in JSON reports
 * `--absolute-paths` replaces `--relative-paths`
 * Fix fingerprint generation to actually use the file path
 * Clean up SQL CVE warning messages
 * Remove deprecated config file locations
 * Add `--only-files` option to specify files/paths to scan ([Ian Ehlert](https://github.com/ehlertij))
 * Add Marshal/CSV deserialization check
 * Combine Marshal/YAML/CSV deserialization checks into single check
 * Avoid duplicate "Dangerous Send" and "Unsafe Reflection" warnings
 * Avoid duplicate results for Symbol DoS check
 * Medium confidence for mass assignment to `attr_protected` models
 * Only treat classes with names containing `Controller` like controllers
 * Better handling of classes nested inside controllers
 * Better handling of controller classes nested in classes/modules
 * Handle `->` lambdas with no arguments ([#331](https://github.com/presidentbeef/brakeman/issues/331))
 * Handle explicit block argument destructuring
 * Skip Rails config options that are real objects ([#324](https://github.com/presidentbeef/brakeman/issues/324))
 * Detect Rails 3 JSON escape config option
 * Much better tracking of warning file names
 * Fix errors when using `--separate-models` ([Noah Davis](https://github.com/noahd1))
 * Fix text report console output in JRuby ([#229](https://github.com/presidentbeef/brakeman/issues/229))
 * Fix false positives on `Model#id`
 * Fix false positives on `params.to_json`
 * Fix model path guesses to use "models/" instead of "controllers/"
 * Use exceptions instead of abort in brakeman lib ([#230](https://github.com/presidentbeef/brakeman/issues/230))
 * Update to Ruby2Ruby 2.0.5

### JSON Report Changes

Several changes were made to JSON reports in this release. The `["scan_info"]["timestamp"]` key was removed, since it was just a duplicate of `["scan_info"]["end_time"]`.

JSON reports now default to reporting relative paths for file names in warnings, which seems to be more useful for external tools. Because of this change, the `--relative-paths` option has been removed and replaced with `--absolute-paths`.

([timestamp change](https://github.com/presidentbeef/brakeman/pull/333), [relative paths change](https://github.com/presidentbeef/brakeman/pull/330))

### Fingerprint Generation

The previous release had a bug where fingerprints were not really including the file name as part of the fingerprint. This has been resolved, and fingerprints should be a reliable way of tracking warnings now.

([changes](https://github.com/presidentbeef/brakeman/pull/317))

### Warning Messages

The warning messages for SQL CVEs were unnecessarily verbose, so they have been trimmed down. Of course, this shouldn't affect anyone, because all apps have upgraded to Rails versions without reported vulnerabilities, right?

Some small changes have been made to other warning messages. Please do not rely on warning messages remaining constant. To track warnings, use the `warning_code` attribute which will never change.

([changes](https://github.com/presidentbeef/brakeman/pull/334))

### Config File Default Locations

The following locations will no longer be automatically searched for Brakeman configuration files:

    * `./config.yaml`
    * `.brakeman/config.yaml`
    * `/etc/brakeman/config.yaml`
    * The Brakeman `lib/` directory

The following locations are still used:

    * `./config/brakeman.yml`
    * `~/.brakeman/config.yml`
    * `/etc/brakeman/config.yml`

Yes, Brakeman can use configuration files. See `brakeman --help` for details.

([changes](https://github.com/presidentbeef/brakeman/pull/310))

### Limiting Scans

While individual files can be exempted from a scan using `--skip-files`, the new `--only-files` option can limit scans to a set of files and directories, thanks to [Ian Ehlert](https://github.com/ehlertij).

([changes](https://github.com/presidentbeef/brakeman/pull/316))

### Deserialization Checks

Brakeman now checks for deserialization of user input using `Marshal`, `YAML`, and `CSV`. The former `YAMLLoad` check has been merged into the new `CheckDeserialize`.

([changes](https://github.com/presidentbeef/brakeman/pull/329))

### Fewer Duplicate Warnings

A few new checks (symbol DoS, dangerous sends, and unsafe reflection) were generating a lot of duplicate warnings. This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/338))

### Nested Classes and Controllers 

Brakeman's previous approach to nested classes was to ignore them. But it appears some people use classes as namespaces and place important classes (like controllers) inside them. This release changes how Brakeman deals with nested classes, as well as classes that inherit from `ApplicationController` but do not have `Controller` in their name. Please see the [pull request](https://github.com/presidentbeef/brakeman/pull/325) for details.

Hopefully this means more accurate scans, but please report any correct warnings from earlier versions missing in 2.0.

([changes](https://github.com/presidentbeef/brakeman/pull/325))

### "Stabby" Lambdas with No Arguments

Errors like `undefined method 'each' for 0:Fixnum` caused by use of `->` lambdas with zero arguments should be fixed now.

([changes](https://github.com/presidentbeef/brakeman/pull/332))

### Explicit Block Argument Destructuring 

Explicit block argument destructuring like this:

    blah do |x, (y,z)|
    end

used to be ignored, but now the arguments are handled in order to keep block arguments in their proper scope.

([changes](https://github.com/presidentbeef/brakeman/pull/307/))

### Rails 3 Config Processing

Brakeman only cares about Rails configuration processing to check for specific settings. It converts a setting like `config.a.b.z` to a hash entry like `[:config][:a][:b][:z]`. However, if real values are found for `config.a.b` this messes things up. So for now they are ignored.

([changes](https://github.com/presidentbeef/brakeman/pull/326))

### Errors from Separating Models

[Noah Davis](https://github.com/noahd1) fixed an error where file names were not being properly set when using the `--separate-models` option.

([changes](https://github.com/presidentbeef/brakeman/pull/313))

### Better File Tracking

Files associated with warnings should be more accurate now, as file information is better preserved during processing.

([changes](https://github.com/presidentbeef/brakeman/pull/318))

### JRuby Console Output

The default text output to a console should now be working again in JRuby. Thanks to [JEG2](https://github.com/jeg2) for pushing out a new version of [HighLine](http://highline.rubyforge.org/).

([changes](https://github.com/presidentbeef/brakeman/pull/339))

### Model#id and to\_json False Positives

There should be fewer warnings generated by `Model#id` and `to_json` calls on `params`.

([changes](https://github.com/presidentbeef/brakeman/pull/309))

### Exceptions instead of Abort

A few instances of `abort` have been removed from Brakeman and replaced with exceptions. This should make it easier to use Brakeman as a library.

([changes](https://github.com/presidentbeef/brakeman/pull/335))

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.


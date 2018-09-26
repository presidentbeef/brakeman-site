---
layout: post
title: "Brakeman 2.1.0 Released"
date: 2013-07-17 16:36
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Brakeman recently passed 250,000 downloads on [RubyGems.org](http://rubygems.org/gems/brakeman)! Thanks to everyone who has contributed!

With this release, the most requested and most controversional feature has been added: it is now possible to ignore warnings based on a configuration file.

Also, the brakeman-min gem has been updated to provide a minimal-dependency version of Brakeman.

_Changes since 2.0.0_:

 * Add support for ignoring warnings
 * Add brakeman-min gem
 * Add check for dangerous model attributes defined in `attr_accessible` ([Paul Deardorff](https://github.com/themetric))
 * Add check for `authenticate_or_request_with_http_basic` ([#301](https://github.com/presidentbeef/brakeman/issues/301))
 * Add `--branch-limit` option, limit to 5 by default
 * Add more methods to check for command injection ([#206](https://github.com/presidentbeef/brakeman/issues/206))
 * Allow use of Slim 2.x ([Ian Zabel](https://github.com/iwz))
 * Load gem dependencies on-demand
 * Output JSON diff to file if `-o` option is used
 * Refactor of SQL injection check code ([Bart ten Brinke](https://github.com/barttenbrinke))
 * Return error exit code when application path is not found
 * Fix detection of duplicate XSS warnings
 * Fix output format detection to be more strict again
 * Fix Gemfile.lock parsing for non-native line endings ([#359](https://github.com/presidentbeef/brakeman/issues/359))
 * Allow empty Brakeman configuration file ([#343](https://github.com/presidentbeef/brakeman/issues/343))
 * Update to ruby\_parser 3.2.2

### Ignoring Warnings

It should be stressed that warnings should only be ignored when it is absolutely certain they are false positives *and* the false positive cannot be fixed on Brakeman's side. If there is uncertainty, please [open an issue](https://github.com/presidentbeef/brakeman/issues/new) so we have the opportunity to improve Brakeman.

The ignore configuration is a JSON file containing a list of warnings and some metadata. Right now the metadata is not actually used, but it might be useful in the future. The only warning information which is actually used is the fingerprint.

By default Brakeman will look for a `brakeman.ignore` file in the `config` directory of the application. This can be changed with the `-i` option.

Since creating and managing the file by hand would be a pain, the `-I` provides interactive management of the ignore configuration.

![brakeman -I](/images/bm-I.png)

JSON reports now include an array of `ignored_warnings`, HTML reports have a table of ignored warnings which is hidden by default, and the basic text output will include the number of warnings ignored, if any.

Again, please use this power responsibly.

([changes](https://github.com/presidentbeef/brakeman/pull/368))

### brakeman-min Gem Updated

You may have noticed the ancient (0.5.2) version of brakeman-min hanging around and hopefully you ignored it.

In order to work "out of the box", Brakeman includes dependencies on HAML, Slim, and Erubis, and depends on several gems for different report types. The brakeman-min gem strips out all optional dependencies, which reduces the gems required from 13 to just 4. This allows you to just install the gems you actually need.

Since the minimal version also removes terminal-table and HighLine, the default output for brakeman-min is JSON. Install those two gems to get the familiar text table report.

The version for brakeman-min will match the regular gem and there are no changes in functionality between the gems.

([changes](https://github.com/presidentbeef/brakeman/pull/367))

### Mass Assignment to Dangerous Attributes

Paul Deardorff has added a new check which warns on model attributes included in `attr_accessible` which perhaps should not have been. 

### More Basic Auth Warnings

Brakeman will now warn on use of password strings used directly in `authenticate_or_request_with_http_basic`.

([changes](https://github.com/presidentbeef/brakeman/pull/362))

### Branch Limiting

When dealing with conditional branches, Brakeman generates basically "union" values of possible values for a given variable. (See one of the many other issues dealing with this for more info, like [#297](https://github.com/presidentbeef/brakeman/pull/297)).

In some situations (lots of assignments to the same variable inside different branches), however, these values can grow to be unreasonably large. In most _useful_ cases, the values aren't that large.

This change introduces a limit on these union values. The default is `5`, which means a given variable should only have five alternative values. If a sixth alternative is encountered (i.e. assignment inside another branch), the old values get kicked out, the new value is saved and the process starts over. This seems like a decent compromise between being flow insensitive (like `--no-branching`) and the current state of affairs (track everything, causing massive slowdowns and memory usage).

To turn off the limiting, use `--branch-limit -1`.

`--branch-limit 0` is almost like `--no-branching` except slower because it's still trying to track stuff.

In testing, a value of `5` did not show any difference in detected vulnerabilities, although it is entirely possible (though empirical evidence points towards unlikely) that some vulnerabilities would be hidden because of this.

(Description copied from the [pull request](https://github.com/presidentbeef/brakeman/pull/345).)

### More Command Injection Methods

Several more Ruby methods for launching processes have been added to the command injection check, including a bunch from [Open3](http://rdoc.info/stdlib/open3/Open3).

([changes](https://github.com/presidentbeef/brakeman/pull/348))

### Support for Slim 2.x

No real changes here, but the gem has been updated to allow Slim 2.x.

([changes](https://github.com/presidentbeef/brakeman/pull/353))

### Gems Loaded On-Demand

Gem dependencies which Brakeman does not need for its core functionality are now loaded as-needed instead of everything being loaded at start time. Besides maybe wasting less time and memory, this enabled the brakeman-min gem discussed above.

([changes](https://github.com/presidentbeef/brakeman/pull/367))

### Output JSON Compare to File

The `-o` option can now be used with `--compare` to output the JSON diff to a file.

If multiple `-o` options are given, the first one will be used for the JSON diff, and the other `-o` files will be used to output a regular report.

([changes](https://github.com/presidentbeef/brakeman/pull/363))

### Error Exit Code When Application Not Found

The last version of Brakeman had a bug where the program would exit with return code `0` when no Rails application was found. It will now return `1` like it did before.

([changes](https://github.com/presidentbeef/brakeman/pull/350))

### Fewer Cross Site Scripting Duplicates

Some cross site scripting warnings were being reported with both high and low confidence. This has been fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/355))

### Stricter Report Format Detection

For a while, Brakeman would match `-o` file names like `blah.jsonness` and assume you wanted JSON output. This is fixed.

([changes](https://github.com/presidentbeef/brakeman/pull/346))

### Parse Gemfile.lock with Non-Native Line Endings

Thanks to Paul Deardorff for updating Gemfile.lock parsing for files created on a different operating system. 

([changes](https://github.com/presidentbeef/brakeman/pull/370)

### Allow Empty Brakeman Config File

Sure, why not?

([changes](https://github.com/presidentbeef/brakeman/pull/344)) 

### RubyParser Update

Brakeman now uses the latest ruby\_parser, which has support for Ruby 2.0 syntax and a lot of bug fixes. You may also notice some line numbers in warnings will be more accurate.

### Report Issues

This was a big release, so please report any [issues](https://github.com/presidentbeef/brakeman/issues)! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.


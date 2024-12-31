---
layout: post
title: "Brakeman 7.0.0 Released"
date: 2024-12-30 21:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Happy new year!

This release of Brakeman contains several breaking changes and updates to default behavior.

_Changes since 6.2.2:_

* Default to using Prism parser if available (disable with `--no-prism`)
* Disable following symbolic links by default (re-enable with `--follow-symlinks`)
* Remove updated entry in Brakeman ignore files ([Toby Hsieh](https://github.com/tobyhs))
* Major changes to how rescanning works
* Fix hardcoded globally excluded paths ([#1830](https://github.com/presidentbeef/brakeman/issues/1830))
* Always warn about deserializing from `Marshal`
* Update `eval` check to be a little noisier
* Output `originalBaseUriIds` for SARIF format report ([#1889](https://github.com/presidentbeef/brakeman/issues/1889))
* Add step (and timing) for finding files
* Fix recursion when handling multiple assignment expressions ([#1877](https://github.com/presidentbeef/brakeman/issues/1877))
* Fix array/hash unknown index handling
* Update `terminal-table` version
* Add CSV library as explicit dependency for Ruby 3.4 support
* Raise minimum Ruby version to 3.1

### Default to Prism Parser

[Prism](https://ruby.github.io/prism/) is a new parser that has quickly been adopted across many Ruby implementations and code tools. In Ruby 3.4, it is now the default parser for Ruby itself.

Thankfully, Prism has also implemented translation layers for RubyParser and other existing parsers. This has allowed Brakeman (and other tools) to adopt Prism fairly easily. Even with the translation layer, Prism is typically a little faster than RubyParser. Line numbers may also shift slightly.

Brakeman now defaults to using Prism for parsing. The `--prism` and `--no-prism` options.

There are still some small incompatibilities - please report any instances where Brakeman outputs `[Format Error]`.

([changes](https://github.com/presidentbeef/brakeman/pull/1897))

### Revert Following Symbolic Links

For better performance, Brakeman will no longer default to following symbolical links for directories. This behavior was added in Brakeman 6.2.1.

To re-enable the previous behavior, use the `--follow-symlinks` option.

([changes](https://github.com/presidentbeef/brakeman/pull/1898))

### Drop Timestamp from Ignore Files

Brakeman will no longer add an `updated` entry when generating or updating an ignore file.

The entry was redundant with source control and could cause unnecessary merge conflicts.

([changes](https://github.com/presidentbeef/brakeman/pull/1860))

### Updates to Rescanning

"Rescanning" in Brakeman (attempting to only scan changed files) has been broken and out of date for a long time. This release drops a lot of that old code.

To improve accuracy, rescanning will now only skip the file reading/parsing step for unchanged files. The rest of the scan will continue like a regular full scan.
For many code bases, the read/parse step is the slowest part of the scan. However, it is very likely the current rescanning will be slower (but more accurate) than the old version.

Hopefully there will be additional improvements in this functionality over time.

For any tools wanting to use rescanning, the initial scan must set `support_rescanning: true` to enable caching of the parsed files. After that, the API is the same.

([changes](https://github.com/presidentbeef/brakeman/pull/1881))

### Globally Excluded Paths

Brakeman has a set of paths that it never scans:

```
  generators/
  lib/tasks/
  lib/templates/
  db/
  spec/
  test/
  tmp/
```

Previously, if any part of the path matched (e.g. `db` matching `cool-db-adapter`), it would get skipped.

Additionally, `log` used to be a skipped path which would match paths like `catalog`.

This has been fixed to only skip paths with an exact match.

([changes](https://github.com/presidentbeef/brakeman/pull/1880))

### More Deserialization Warnings

Brakeman will now warn about all uses of `Marshal.load` or `Marshal.restore`.

This may be a little noisy, so please feel free to provide feedback on false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/1902))

### More Eval Warnings

Brakeman will now warn about evaluation of dynamic strings, even if there is no obvious user-controllable input.

In addition, Brakeman will warn about most uses of `eval`.

This may be a little noisy, so please feel free to provide feedback on false positives.

([changes](https://github.com/presidentbeef/brakeman/pull/1899))

### SARIF Reports

SARIF reports output from Brakeman will now include the `originalBaseUriIds` property to enable using of absolute file paths inside of the report. This should enhance compatibility with GitHub and other tools.

See the ([changes](https://github.com/presidentbeef/brakeman/pull/1890)) for details of how this interacts with scan paths.

### Step for Finding Files

For large applications, just listing out relevant files for Brakeman to scan can take some time.

This step was previously "invisible" but now Brakeman will output `Finding files...` as a descrete step which also means it will work with the `--timing` option to display how long that step takes.

([changes](https://github.com/presidentbeef/brakeman/pull/1896))

### Dependency Updates

Brakeman no longer restricts `terminal-table` to an old version.

([changes](https://github.com/presidentbeef/brakeman/pull/1901))

`csv` is now an explicit dependency since it has moved to a bundled gem in Ruby 3.4.

([changes](https://github.com/presidentbeef/brakeman/pull/1893))

The minimum Ruby version to run Brakeman is now Ruby 3.1.0.

([changes](https://github.com/presidentbeef/brakeman/pull/1888))

### Checksums

The SHA256 sums for this release are:



### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Hang out [on Github](https://github.com/presidentbeef/brakeman/discussions) for questions and discussion.

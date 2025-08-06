---
layout: blog
title: Brakeman 4.8.0 Released
date: 2020-02-18 10:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.7.2
  changes:
  - Add JUnit XML report format ([Naoki Kimurai](https://github.com/naokikimura))
  - Sort ignore files by fingerprint and line ([Ngan Pham](https://github.com/ngan))
  - Catch dangerous concatenation in `CheckExecute` ([Jacob Evelyn](https://github.com/JacobEvelyn))
  - User-friendly message when ignore config file has invalid JSON ([D. Hicks](https://github.com/deevis))
  - Freeze call index results, fix thread-safety issue
  - Properly render confidence in Markdown report ([#1446](https://github.com/presidentbeef/brakeman/issues/1446))
  - Report old warnings as fixed if zero warnings reported
checksums:
- hash: 2febb3ce4111fe14f57a8ea447c5770eeb32ba43333955b4ed27864ef045c277
  file: brakeman-4.8.0.gem
- hash: c513373a37576d8107af724bf9f8a47e8d76253c85bdd6fdb4d3e93471a47ee6
  file: brakeman-lib-4.8.0.gem
- hash: d82206b9a60ef1eb4c96d32ba0157774db301e3ca10dcbdd7b4171044b28eccf
  file: brakeman-min-4.8.0.gem
---


First release of 2020!
This release comes with a brand new report format: JUnit XML.


## JUnit XML Report

Thanks to [Naoki Kimura](https://github.com/naokikimura), Brakeman can now generate a JUnit XML format.
JUnit XML is produced and consumed by a number of different testing tools, including CircleCI.

Supporting this format makes it possible for Brakeman warnings to be consumed by general test infrastructure tools.

To use the new format, either use `-f junit` or `-o report.junit`.

[changes](https://github.com/presidentbeef/brakeman/pull/1453)

## Sort Ignore Files

Warnings in "ignore files" were previously only sorted by fingerprint.
Thanks to [Ngan Pham](https://github.com/ngan) they are now sorted by fingerprint then line number, to maintain stable ordering between warnings with the same fingerprint.

[changes](https://github.com/presidentbeef/brakeman/pull/1457)

## Dangerous Concatenation in Commands

[Jacob Evelyn](https://github.com/JacobEvelyn) has updated the command injection check (`CheckExecute`) to also consider string concatenation with dangerous values.

For example:

```
system("ls " + maybe_dangerous)
```

[changes](https://github.com/presidentbeef/brakeman/pull/1440)

## Fix Thread-safety Issue

Two checks were modifying shared data (call site results), which introduced a race condition.
Sometimes a result would strangely become `nil` and cause intermittent errors.
Note this only popped up when using real threads on JRuby.

Now results from the `CallIndex` are frozen to help prevent this kind of modification of shared data in the future.

[changes](https://github.com/presidentbeef/brakeman/pull/1452)

## Render Confidence in Markdown

Due to a previous refactoring, confidence levels were not being rendered in Markdown reports.

[changes](https://github.com/presidentbeef/brakeman/pull/1448)

## Report Comparison Fix 

Due to a _very_ old bug, when comparing an old report with some warnings to a new report with zero warnings, the old warnings were not reported as fixed.
Now they will be.

Probably no one noticed because we generally only care about _new_ warnings.

[changes](https://github.com/presidentbeef/brakeman/pull/1448)


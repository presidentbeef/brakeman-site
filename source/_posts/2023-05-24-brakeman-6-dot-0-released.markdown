---
layout: blog
title: Brakeman 6.0.0 Released
date: 2023-05-24 15:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 5.4.1
  changes:
  - Drop support for Ruby 1.8/1.9 syntax
  - Raise minimum Ruby version to 3.0
  - Add obsolete fingerprints to comparison report ([#1758](https://github.com/presidentbeef/brakeman/issues/1758))
  - Warn about missing CSRF protection when defaults are not loaded ([Chris Kruger](https://github.com/montdidier))
  - Fix false positive with `content_tag` in newer Rails ([#1778](https://github.com/presidentbeef/brakeman/issues/1778))
  - Scan directories that include the word `public`
  - Fix end-of-life dates for Ruby
checksums:
- hash: 6ff908e5bfca4651d909a31f3d3ae5846e33732284860a23aff454761c4145d0
  file: brakeman-6.0.0.gem
- hash: 9a5e68e34c1cffe73b51952937ed2b4f427afd5d11d4a1c10c61e971253ba505
  file: brakeman-lib-6.0.0.gem
- hash: db1d8e2118af4b4701fbe49bf1177ac5c89a6a956ca037fdc0e62eb062e2dbb9
  file: brakeman-min-6.0.0.gem
---


Brakeman 6.0 drops parsing support for Ruby 1.8/1.9, and raises the minimum Ruby version to run Brakeman to 3.0.



## Ruby Parsing Version Support 

This version of Brakeman no longer supports parsing Ruby 1.8/1.9 syntax.

`ruby_parser`, the gem Brakeman depends on for parsing Ruby, dropped support quite a while ago. Brakeman was depending on the `ruby_parser-legacy` gem for these older versions. But since it has been eight years since Ruby 1.9 has been unmaintained... it is time to let go.

([changes](https://github.com/presidentbeef/brakeman/pull/1771))

## Minimum Ruby Version

The minimum Ruby version to run Brakeman is now 3.0.0.

Official support for the 2.x line of Ruby has ended, so it is a good time to bump up the minimum requirement and adopt more modern language features.

([changes](https://github.com/presidentbeef/brakeman/pull/1771))

## Missing CSRF Protection Warning

Since Rails 5.2.0, new applications have had cross-site request forgery protection enabled. Brakeman assumed the protection was enabled based on the Rails version. However, this was incorrect.

Now Brakeman correctly handles the default configuration values.

([changes](https://github.com/presidentbeef/brakeman/pull/1776))

## Content Tag Attributes

Brakeman will no longer warn about user input in `content_tag` attribute names in Rails 6.1.6+

([changes](https://github.com/presidentbeef/brakeman/pull/1779)

## Obsolete Warnings in Comparison Report

When using the `--compare` option, the output JSON will now include an `obsolete` key with an array of fingerprints.

These fingerprints are warnings that are configured to be ignored, but no longer exist.

Note that the report will include _all_ fingerprints in the ignore configuration that are not in the current report, even if they were already obsolete.

This report format matches the `--json` output.

The report will resemble:

```
{
  "new": [ ... ],
  "fixed": [ ... ],
  "obsolete": [
    "abcdef01234567890ba28050e7faf1d54f218dfa9435c3f65f47cb378c18cf98"
  ]
}
```

([changes](https://github.com/presidentbeef/brakeman/pull/1777))

## Scan 'public' Directories

In the old days, Brakeman tried to scan only the "standard" Rails directories, mostly within `/app/`. With the 5.0 release, Brakeman was revised to make very few assumptions about what kinds of files live where, instead making decisions based on the content of files rather than their location.

However, there was a lingering exception. Brakeman would ignore any directories that included `/public/`. 

This exception has been removed.

([changes](https://github.com/presidentbeef/brakeman/pull/1774))

## EOL Dates for Ruby

Fixed end-of-life date for Ruby 3.0 and added expected dates for 3.1 and 3.2.

([changes](https://github.com/presidentbeef/brakeman/pull/1770))


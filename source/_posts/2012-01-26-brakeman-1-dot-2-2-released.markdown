---
layout: post
title: "Brakeman 1.2.2 Released"
date: 2012-01-26 13:58
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

*Changes since 1.2.1:*

 * --no-progress works again
 * Make CheckLinkTo a separate check
 * Don't fail on unknown options to resource(s)
 * Handle empty resource(s) blocks
 * Add RescanReport#existing_warnings

### No Progress Option

The last release broke the `--no-progress` option for hiding the `1/100 files processed` type messages. Now it works again!

### Separate Check for link_to

For no great reason, `CheckLinkTo` was bundled with `CheckCrossSiteScripting`. It has now been moved out to a separate file, allowing it to be treated as a regular check. This means it can be explicitly skipped using `-x CheckLinkTo` (if desired).

### Better Rails 2 Route Handling

Brakeman was raising an exception if a hash option to `resource` or `resources` did not match a set of known options. Now it will only warn instead of aborting route processing.

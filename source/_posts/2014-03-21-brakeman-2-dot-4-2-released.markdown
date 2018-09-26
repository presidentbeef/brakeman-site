---
layout: post
title: "Brakeman 2.4.2 Released"
date: 2014-03-20 22:37
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This release is only internal changes and bug fixes, but some scans may see significant time and memory improvements.

*Changes since 2.4.1*:

 * Skip identically rendered templates
 * Improve HAML template processing
 * Only track original template output locations
 * Reuse duplicate call location information
 * Fix duplicate warnings about sanitize CVE
 * Remove `rescue Exception`

### Drop Identical Templates

For a long time now Brakeman has skipped processing templates if the template had already been processed with an identical environment. However, there are many times when a template is rendered with different environments but the actual output is the same. Brakeman now drops these templates (they are rendered, then discarded if they are duplicates). This reduces peak memory overhead, sometimes drastically. It can also speed up call indexing and vulnerability checks since fewer templates are searched.

The location and render path of template warnings may change slightly due to this change. Also, the rendered template debug output will no longer include all rendered templates since duplicates will not be tracked.

([changes](https://github.com/presidentbeef/brakeman/pull/442))

### Better HAML Processing

HAML templates will be processed more accurately with this release.

For example, a template like this

    #content
      .nav
        = @navigation_menu

used to produce output like

    +-------------------------------------------------------------------------------------------------+
    | Output                                                                                          |
    +-------------------------------------------------------------------------------------------------+
    | [Output] "<div id='content'>; <div class='nav'>; #{[Escaped] @navigation_menu}; </div>;</div>;" |
    +-------------------------------------------------------------------------------------------------+

but now it will look like this instead

    +-----------------------------------+
    | Output                            |
    +-----------------------------------+
    | [Escaped Output] @navigation_menu |
    +-----------------------------------+

Besides looking much nicer, this improves warnings and reduces how much code Brakeman has to search. Additionally, these `push_text` methods can often interpolate multiple values into the output string, which were not being properly detected as output. This is fixed now. 

([changes](https://github.com/presidentbeef/brakeman/pull/441))

### Duplicate Template Outputs 

Aliased values in templates were being counted multiple times as output. This did not affect warnings generated, but it did create duplicate output values to check and extraneous debug output.

([changes](https://github.com/presidentbeef/brakeman/pull/443))

### Call Location Reuse

For large applications, many calls in the call index actually have the same location (class+method or template). Instead of creating a new location hash for each call, the locations are cached and reused.

([changes](https://github.com/presidentbeef/brakeman/pull/444))

### Sanitize CVE Duplicates

Don't worry - [CVE-2013-1857](https://groups.google.com/d/msg/rubyonrails-security/zAAU7vGTPvI/1vZDWXqBuXgJ) is one year old this week. But Brakeman was not properly preventing duplicate warnings for it. Hopefully this was affecting exactly no one.

([changes](https://github.com/presidentbeef/brakeman/pull/445))

### Narrower Exception Handling

All instances of `rescue Exception` were removed from Brakeman and replaced with bare `rescue`s to catch `StandardError` and subclasses. `Exception` has some unfortunate subclasses, such as `NoMemoryError` and `Interrupt` which Brakeman should not be rescuing.

This does mean there may be some newly unhandled exceptions. Please report these so they can be rescued properly.

([changes](https://github.com/presidentbeef/brakeman/pull/446))

### SHAs

The SHA1 sums for this release are

    02842dc497bf22b5b427cfd02635c005c4fc4fd4  brakeman-2.4.2.gem
    4893cedbcb015e96c82f4777b00a49ca8d0ae22f  brakeman-min-2.4.2.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/). 

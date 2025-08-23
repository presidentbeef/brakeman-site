---
layout: blog
title: Brakeman 1.2.1 Released
date: 2012-01-20 12:16
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.2.0
  changes:
  - " * Remove link_to warning for Rails 3.x or when using rails_xss"
  - " * Don't warn if first argument to link_to is escaped"
  - " * Detect usage of attr_accessible with no arguments"
  - " * Fix error when rendering a partial from a view but not through a controller"
  - " * Fix some issues with rails_xss, CheckCrossSiteScripting, and CheckTranslateBug"
  - " * Simplify Brakeman Rake task"
  - " * Avoid modifying $VERBOSE"
  - " * Add Brakeman::RescanReport#to_s"
  - " * Add Brakeman::Warning#to_s"
---


This is essentially just a bugfix release, but due to the fixes for `link_to` warnings, there is a good possibility the number of reported warnings will decrease when upgrading to this version.

Changes since 1.2.0: 

 * Remove link_to warning for Rails 3.x or when using rails_xss
 * Don't warn if first argument to link_to is escaped
 * Detect usage of attr_accessible with no arguments
 * Fix error when rendering a partial from a view but not through a controller
 * Fix some issues with rails_xss, CheckCrossSiteScripting, and CheckTranslateBug
 * Simplify Brakeman Rake task
 * Avoid modifying $VERBOSE
 * Add Brakeman::RescanReport#to_s
 * Add Brakeman::Warning#to_s

## link_to Changes

Prior to Rails 3.0, there [was a bug](https://rails.lighthouseapp.com/projects/8994/tickets/3518-link_to-doesnt-escape-its-input) in `link_to` that caused the body of the link tag to be output without escaping. While this was fixed in Rails 3.0, Brakeman has still been warning on it. This was also fixed in the [rails_xss](https://github.com/rails/rails_xss/commit/afc1610fe4b94150faee98c16f15a24290d20900), so Brakeman should no longer warn on `link_to` for Rails 2.x when using the rails_xss plugin.

Brakeman was also warning on `link_to` even if the body argument was manually escaped. This should be resolved now.

One other related issue was a silly bug causing Brakeman to sometimes ignore `--escape-html` or the rails_xss plugin, leading to some confusing output. This is fixed.

Thanks to [Neil Matatall](https://github.com/presidentbeef/brakeman/issues/32) for reporting the `link_to` issue and [Andreas](https://github.com/a5sk4s) for reporting the rails_xss problems.

## attr_accessible with No Arguments

Brakeman was not detecting the case where `attr_accessible` is called with zero arguments, causing spurious mass assignment warnings.

Thanks to [Justin Wiley](https://github.com/presidentbeef/brakeman/issues/31) for reporting this.

## Brakeman Rake Task

The Brakeman Rake task (installed via `--rake`) is even [simpler now](/docs/rake).

## $VERBOSE

Brakeman was using `$VERBOSE` and `Kernel.warn` for controlling debug output. This has changed and `$VERBOSE` will no longer be modified when using Brakeman.

## Rails 3.2 Support

So far, there have not been any issues with Brakeman and Rails 3.2. Please [report](https://github.com/presidentbeef/brakeman/issues) any that come up!

## JRuby Performance

Prior to Brakeman 1.2, [JRuby](http://jruby.org/) was very slow when running Brakeman. This has changed, and now JRuby is probably the fastest option for scanning large applications. Give it a try, especially if you are using Ruby 1.8.7!

## Mailing List

There is now a Brakeman mailing list on [librelist](http://librelist.com/browser/brakeman/). 

To subscribe, send any email to <a href='&#109;ailto&#58;b&#114;%&#54;1k&#37;65m&#37;&#54;1n&#64;&#37;6Ci&#98;%&#55;2&#101;l%&#54;&#57;st&#46;com'>brakeman&#64;libr&#101;&#108;ist&#46;com</a>. You will be asked to confirm your subscription.

Archives are available for browsing on [The Mail Archive](http://www.mail-archive.com/brakeman@librelist.com/maillist.html).

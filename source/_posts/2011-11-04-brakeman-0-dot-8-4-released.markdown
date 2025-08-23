---
layout: blog
title: "Brakeman 0.8.4 Released"
date: 2011-11-04 14:58
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---

Changes:

 * Option for separate attr_accessible warnings
 * Option to set CSS file for HTML output
 * Add file names for version-specific warnings
 * Add line number for default routes in a controller
 * Fix hash_insert()
 * Remove use of Queue from threaded checks


## Separate attr_accessible Warnings

The current default is to roll all controllers lacking `attr_accessible` into a single warning. This is convenient when manually looking at HTML or text output, but for Jenkins/Hudson it is better to have each be a separate warning. That way it is easier to track new and fixed warnings.

To turn on this behavior, use `--separate-models`.

## Custom CSS for HTML Output

Use the `--css-file` option to set a custom CSS file for styling HTML output. This file is copied directly into the report.

## File Names for Version-Specific Warnings

Previously, there would be no file name associated with warnings about certain versions of Rails. This caused the warnings to not show up in the Jenkins/Hudson plugin. Now either `Gemfile` or `config/environment.rb` will be used as the file name for warnings based on the detected Rails version.

## Line Number for Default Routes

When default routes were detected for specific controllers, there will now be a line number (from `routes.rb`) associated with the warning.

## hash_insert() Fixed

`hash_insert` was broken and would cause some spurious warnings. For example, sometimes `only_path => true` would be set in `params`, but Brakeman would mess up the `params` hash and a redirect warning would still be created.

## Threaded Checks No Longer Use Queue

When using threaded checks, the resulting warnings were stored in a thread-safe Queue. This has been removed, and the resulting value from each thread will be used instead. This should avoid some (small) locking overhead and is just simpler.

## "Like" Brakeman on Ruby Toolbox

Please consider 'liking' Brakeman on the [Ruby Toolbox](https://www.ruby-toolbox.com/projects/brakeman)!

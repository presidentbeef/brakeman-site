---
layout: blog
title: Brakeman 0.8.3 Released
date: 2011-10-25 10:00
permalink: "/blog/:year/:month/:day/:title"
---


Changes for 0.8.3:

 * Respect -w flag in .tabs format ([tw-ngreen](https://github.com/tw-ngreen))
 * Escape HTML output of error messages
 * Add --skip-libs option

Changes since 0.8.0:

 * Run checks in parallel threads by default
 * Fix compatibility with ruby_parser 2.3.1
 * Add option to assume all controller methods are actions
 * Recover from errors when parsing routes

## Fix for .tabs Format

Brakeman will now pay attention to the `-w` flag (setting minimum confidence levels) when using the `.tabs` format.

## Escape Error Messages in HTML

Error message will now be escaped in the HTML output so they do not mess up the formatting.

## --skip-libs Option

The `--skip-libs` option will cause Brakeman to not process the files in the `lib` directory. At the moment, the results from this directory are only used in a couple places, so it is unlikely that skipping them will cause any problems.

## Parallel Checks

Checks are now run in separate threads by default. Thus far, there does not seem to be a big difference between using threads and the sequential approach. To turn off threads, use the `-n` option.

## ruby_parser Compatibility

This is a stop-gap measure until [ruby_parser](https://github.com/seattlerb/ruby_parser) supports Ruby 1.9, which is getting closer to reality.

## Route Processing

Brakeman will no longer crash if there are problems parsing `routes.rb`. Instead, it will assume all public methods on controllers are actions. The `-a` option will also turn this behavior on. 

Rails 3.1 route parsing is still a work in progress, so this should at least allow analysis of 3.1 apps, even if it means slightly reduced accuracy.

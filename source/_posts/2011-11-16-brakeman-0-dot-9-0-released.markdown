---
layout: post
title: "Brakeman 0.9.0 Released"
date: 2011-11-16 16:23
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---

Changes:

 * Process Rails 3 configuration files
 * Check for config.active_record.whitelist_attributes = true
 * Always produce a warning for without_protection => true
 * Fix CSV output

This is just a small release on the way to 1.0.

### Rails 3 Configs

Configurations in `config/application` and `config/environments/production.rb` will now be parsed.

### Check for Disabled Mass Assignment

A new option was added in Rails 3.1 to globally disable mass assignment using `config.active_record.whitelist_attributes = true`. Brakeman will now turn off mass assignment warnings if this configuration setting is detected.

### Always Warn on without_protection

Rails 3.1 adds a way to bypass attribute protection when doing mass assignment.

For example:

    User.new(params, :without_protection => true)

Brakeman will now _always_ warn when `without_protection` is used, even if mass assignment is disabled or attributes are protected on that model.

### Fix CSV Output

Brakeman reports using the CSV format should work once again.

There is a bug in Ruport when using Ruby 1.9.2 and CSV output. A temporary patch has been added until this is resolved.

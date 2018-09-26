---
layout: post
title: "Brakeman 0.8.0 Released"
date: 2011-09-15 10:06
comments: true
categories: release 
permalink: /blog/:year/:month/:day/:title
---

Change list for Brakeman 0.8.0:

 * Add check for mass assignment using without_protection
 * Add check for password in http_basic_authenticate_with
 * Warn on user input in hash argument with mass assignment
 * auto_link is now considered safe for Rails >= 3.0.6
 * Output detected Rails version in report
 * Keep track of methods called in class definition
 * Add ruby_parser hack for Ruby 1.9 hash syntax
 * Add a few Rails 3.1 tests

As always, please [report any issues](https://github.com/presidentbeef/brakeman/issues).

## New Checks

This release adds two checks specific to Rails 3.1.

The first looks for mass assignment which deliberately bypasses attribute protection. For example:

    User.new(params[:user], :without_protection) => true)

If user input is used for initializing the record, the warning will be set to high confidence. Otherwise, it will show up as medium confidence.

The second new check looks for controllers using the new `http_basic_authenticate_with` method and including the password directly in the source.

The example from the [Rails guide](http://guides.rubyonrails.org/getting_started.html) looks like this:

    class PostsController < ApplicationController
 
      http_basic_authenticate_with :name => "dhh", :password => "secret", :except => :index

      #...

    end

This would raise a warning, mostly because it is a bad idea to have passwords in plain text right in your source code.

## Changes to Existing Warnings

Mass assignment has been changed to raise a warning if there is any user input when calling `Model.new`.

`auto_link` was previously set to be a "known dangerous" method because it did not escape its output. That was fixed in Rails 3.0.6, so it will be considered safe for versions 3.0.6 and up. But then `auto_link` was removed in Rails 3.1, so for 3.1 and up it will be treated as a regular method.

## Changes to Output

Warnings reports will now include the detected Rails version as part of the information reported.

## Support for Ruby 1.9 Hash Syntax

[RubyParser](https://github.com/seattlerb/ruby_parser), used by Brakeman for all its Ruby parsing needs, [does not support the new Ruby 1.9 syntax](http://blog.zenspider.com/2010/12/bounty-ruby-parser-needs-19-lo.html). After coming across an application which uses the [1.9 hash syntax](http://blog.peepcode.com/tutorials/2011/rip-ruby-hash-rocket-syntax) _extremely_ liberally, a temporary hack has been added that should allow Brakeman to parse it correctly.

This does mean that Brakeman is overriding RubyParser's code to add in this functionality. That is why it is a _temporary hack_.

## New Tests

Work has begun on a test application using Rails 3.1. There do not seem to be any huge changes in 3.1 that would prevent Brakeman from working, though.

## Next Version

The main area of focus for the next (major) release will be Rails 3.x routing. Brakeman is currently quite limited in what kinds of routes in understands.

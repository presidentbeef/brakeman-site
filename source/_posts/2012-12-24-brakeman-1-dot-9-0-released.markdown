---
layout: blog
title: Brakeman 1.9.0 Released
date: 2012-12-25 11:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.8.3
  changes:
  - " * Update to RubyParser 3"
  - " * Ignore route information by default"
  - ' * Add optional "interprocedural" analysis for controllers'
  - " * Properly pass instance variables between before\_filters"
  - " * Support `strong_parameters` ([#88](https://github.com/presidentbeef/brakeman/issues/88))"
  - " * Support newer `validates :format` call ([#198](https://github.com/presidentbeef/brakeman/issues/198))"
  - " * Add scan time to reports ([#158](https://github.com/presidentbeef/brakeman/issues/158))"
  - " * Add Brakeman version to reports"
  - " * Don't mangle whitespace in JSON code formatting"
  - " * Fix `CheckExecute` to warn on all string interpolation ([#213](https://github.com/presidentbeef/brakeman/issues/213))"
  - " * Fix false positive on `to_sql` calls"
  - " * Add AppTree as facade for filesystem ([Bryan Helmkamp](https://github.com/brynary))"
  - " * Add link for translate vulnerability warning ([Michael Grosser](https://github.com/grosser))"
  - " * Add Rakefile to run tests ([Michael Grosser](https://github.com/grosser))"
  - " * Better default config file locations ([Michael Grosser](https://github.com/grosser))"
  - ' * Remove "find by regex" feature from `CallIndex`'
  - " * Reduce Sexp creation"
  - " * Handle empty model files"
---


Happy [Eggnog Riot](https://en.wikipedia.org/wiki/Eggnog_Riot) day!

This is a major release: 95 changed files with 1,775 additions and 14,484 deletions. This provides ample room for new bugs, so please report any issues.



## Update to RubyParser 3

With the update to use RubyParser 3.x, Brakeman no longer includes a vendored version of RubyParser (which was only used with running with Ruby 1.9), which reduced code size by about 14,000 lines.

RubyParser 3 supports Ruby 1.9 much more fully, so there should be very few parse errors. Additionally, Brakeman no longer chooses parsers based on the current Ruby version.

([changes](https://github.com/presidentbeef/brakeman/pull/190))

## Route Information Ignored by Default

Route information is only used in Brakeman to determine whether a controller method should perform an implicit render. Since determining Rails routes statically is quite difficult to get right, it is better to assume a method is a routable action. Previous versions provided the `-a` option for this, which is now on by default. To turn off this behavior (and revert to the old), use `--no-assume-routes`.

This does not affect default route warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/219))

## Optional Interprocedural Analysis for Controllers

Currently, Brakeman essentially looks at each method in isolation. Values are propagated from controller actions (including before\_filters) through rendered views and templates. But if a controller action calls another method which has an effect on the eventual output of the action, Brakeman does not processed the invoked method.

This release includes optional, experimental support for analyzing controller methods called from within controller actions.

For a simple example, instance variables set in helper methods will now be added to a rendered view. Also, values returned from called methods will be tracked:

    def create
      get_user 
      #@user is now User.find(params[:id])

      @account = find_account(@user)  
      #@account is now Account.where(:user => User.find(params[:id]).id
    end

    private

    def get_user
      @user = User.find(params[:id])
    end

    def find_account
      Account.where(:user => @user.id)
    end

This is limited to methods available in the controller (via a parent class or mixins). It is also limited to a "depth of one", meaning it will not try to analyze methods called by helper methods (`get_user` and `find_account` above). 

Since this feature is still experimental and will definitely increase scan times, it is turned off by default. Use `--interprocedural` to enable it. (Better name pending suggestions...)

([changes](https://github.com/presidentbeef/brakeman/pull/218))

## Pass Instance Variables between Filters

While instance variables set in `before_filters` were set properly, `before_filter` which used instance variables from an earlier filter could not see those variables. This has been fixed, which will likely lead to new or more accurate warnings.

([changes](https://github.com/presidentbeef/brakeman/pull/224))

## Support for `strong_parameters`

In Rails 4, the responsibility for mass assignment protection will move from models to controllers where mass assignment is actually used. A preview of the new functionality is available in the [strong_parameters](https://github.com/rails/strong_parameters) gem. Brakeman should no longer warn on mass assignment for models protected with `strong_parameters`. 

([changes](https://github.com/presidentbeef/brakeman/pull/204))

## Support `validates :format`

In Rails 3, format validation changed from `validates_format_of` to the more generic `validates` method. Brakeman will now check `validates` calls for proper anchors on regular expressions for `:format`.

([changes](https://github.com/presidentbeef/brakeman/pull/205))

## Report Changes

Reports will now contain Brakeman version and scan duration. JSON reports contain `start_time` and `end_time` timestamps. For now, JSON reports will still have a `timestamp` key, but it will be identical to `end_time`. It will be removed in Brakeman 2.0.

([changes](https://github.com/presidentbeef/brakeman/pull/193))

Additionally, code formatting in JSON reports has changed slightly. Previously, code was formatted with the HTML output in mind, so line breaks were removed. Now JSON reports include the code formatted from Ruby2Ruby without any mangling.

([changes](https://github.com/presidentbeef/brakeman/pull/191))

## Fix Command Injection Check

The command injection check will now (again) warn on any form on string interpolation used for process execution, whether or not user input is involved.

([changes](https://github.com/presidentbeef/brakeman/pull/216))

## Fix `to_sql` False Positives

SQL code generated from Arel's `to_sql` method will be considered safe.

([changes](https://github.com/presidentbeef/brakeman/pull/194))

## File System Facade

Bryan Helmkamp cleaned up Brakeman's file access into a single object. This should simplify future changes and add some consistency to how Brakeman handles files.

([changes](https://github.com/presidentbeef/brakeman/pull/197))

## Run Tests via Rake

Thanks to Michael Grosser, running `rake` will now run Brakeman's tests. 

([changes](https://github.com/presidentbeef/brakeman/pull/183))

## Improved Config File Locations

Also thanks to Michael Grosser, Brakeman will check more sane locations for Brakeman configuration files. This version adds `./config/brakeman.yml`, `~/.brakeman/config.yml`, and `/etc/brakeman/config.yml` as default locations for configuration files. The old locations are deprecated now, and will be removed in Brakeman 2.0.

([changes](https://github.com/presidentbeef/brakeman/pull/182)

## More Internal Changes

Call indexing performance has been given another [slight boost](http://blog.presidentbeef.com/) with the removal of the ability to search for call targets via regular expressions (which was not being used anywhere).

([changes](https://github.com/presidentbeef/brakeman/pull/189))

The number of s-expressions generated by Brakeman has been reduced, although this did not lead to any major performance improvement.

([changes](https://github.com/presidentbeef/brakeman/pull/207))

Data-flow/alias processing was performing two passes. This has been reduced to just one.

([changes](https://github.com/presidentbeef/brakeman/pull/224))

Empty model files will no longer cause errors.

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.


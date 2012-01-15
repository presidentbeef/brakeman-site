---
layout: page
title: "Brakeman as a Library"
date: 2012-01-10 10:48
comments: false
sharing: false
footer: true
---

Brakeman was initially designed to be used a command-line application. Recently, there have been some changes to allow it to be used as a library as well. Future releases will likely make it even easier to use.

### Simple Example

Here is a simple example:

    require 'brakeman'

    tracker = Brakeman.run "my/app"

    puts tracker.report

This runs Brakeman against the Rails application in `my/app` and prints out the report. This is essentially equivalent to running Brakeman with no options.

`Brakeman.run` returns a `Tracker` object ([doc](http://rubydoc.info/github/presidentbeef/brakeman/master/frames)) which contains all the information from the scan. `Tracker#checks` ([doc](http://rubydoc.info/github/presidentbeef/brakeman/master/frames)) holds the results from running the checks.

### Using Options

Most of the command-line options for Brakeman can be used with `Brakeman.run`, but the names may be slightly different.

If an options hash is used, then `:app_path` must be specified instead of just a string for the path:

    Brakeman.run :app_path => "my/app"

Here is a list of options:

 * :app_path - path to root of Rails app (required)
 * :assume_all_routes - assume all methods are routes (default: false)
 * :check_arguments - check arguments of methods (default: true)
 * :collapse_mass_assignment - report unprotected models in single warning (default: true)
 * :combine_locations - combine warning locations (default: true)
 * :config_file - configuration file
 * :escape_html - escape HTML by default (automatic)
 * :exit_on_warn - return false if warnings found, true otherwise. Not recommended for library use (default: false)
 * :html_style - path to CSS file
 * :ignore_model_output - consider models safe (default: false)
 * :message_limit - limit length of messages
 * :min_confidence - minimum confidence (0-2, 0 is highest)
 * :output_file - file for output
 * :output_format - format for output (:to_s, :to_tabs, :to_csv, :to_html)
 * :parallel_checks - run checks in parallel (default: true)
 * :print_report - if no output file specified, print to stdout (default: false)
 * :quiet - suppress most messages (default: true)
 * :rails3 - force Rails 3 mode (automatic)
 * :report_routes - show found routes on controllers (default: false)
 * :run_checks - array of checks to run (run all if not specified)
 * :safe_methods - array of methods to consider safe
 * :skip_libs - do not process lib/ directory (default: false)
 * :skip_checks - checks not to run (run all if not specified)


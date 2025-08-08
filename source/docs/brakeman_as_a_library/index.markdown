---
layout: docs
title: "Brakeman as a Library"
date: 2012-01-10 10:48
comments: false
sharing: false
footer: true
---

Brakeman was designed to be used a command-line application, but it is possible to run it as a library.

### Simple Example

Here is a simple example:

    require 'brakeman'

    tracker = Brakeman.run "my/rails_app"

    puts tracker.report

This runs Brakeman against the Rails application in `my/rails_app` and prints out the report. This is essentially equivalent to running Brakeman with no options.

`Brakeman.run` returns a `Tracker` object ([doc](http://rubydoc.info/github/presidentbeef/brakeman/master/frames)) which contains all the information from the scan. `Tracker#checks` ([doc](http://rubydoc.info/github/presidentbeef/brakeman/master/frames)) holds the results from running the checks.

### Using Options

Most of the command-line options for Brakeman can be used with `Brakeman.run`, but the names may be slightly different.

If an options hash is used, then `:app_path` must be specified instead of just a string for the path:

    Brakeman.run app_path: "my/rails_app"

Below is a list of options, but always [check the source](https://github.com/presidentbeef/brakeman/blob/master/lib/brakeman/options.rb) for the latest.

* `:app_path` - Path to root of Rails app (required)
* `:absolute_paths` - Show absolute path of each file (default: false)
* `:additional_checks_path` - Array of additional directories containing additional out-of-tree checks to run
* `:additional_libs_path` - Array of additional application relative lib directories (ex. app/mailers) to process
* `:allow_check_paths_in_config` - Allow loading checks from configuration file (unsafe, default: false)
* `:assume_all_routes` - Assume all methods are routes (default: true)
* `:branch_limit` - Limit branching during dataflow analysis
* `:check_arguments` - Check arguments of methods (default: true)
* `:collapse_mass_assignment` - Report unprotected models in single warning (default: false)
* `:combine_locations` - Combine warning locations (default: true)
* `:config_file` - Configuration file
* `:debug` - Verbose debug messages (default: false)
* `:engine_paths` - Array of paths to Rails engines
* `:escape_html` - Escape HTML by default (automatic)
* `:exit_on_error` - Only affects Commandline module (default: true)
* `:exit_on_warn` - Only affects Commandline module (default: true)
* `:force_scan` - Scan application even if Rails is not detected
* `:github_repo` - Github repo to use for file links (user/repo[/path][@ref])
* `:highlight_user_input` - Highlight user input in reported warnings (default: true)
* `:html_style` - Path to CSS file
* `:ignore_file` - File to configure ignoring false positives
* `:ignore_model_output` - Consider models safe in some checks (default: false)
* `:index_libs` - Add libraries to call index (default: true)
* `:min_confidence` - Minimum confidence (0-2, 0 is highest)
* `:output_color` - Colorize text output format (automatic)
* `:output_files` - Array of file names for output
* `:output_formats` - Formats for output (`:text`, `:json`, `:junit`, `:html`, `:table`, :`tabs`)
* `:pager` - Use pager for output (automatic)
* `:parallel_checks` - Run checks in parallel (default: true)
* `:parser_timeout` - Set timeout for parsing an individual file (default: 10 seconds)
* `:print_report` - If no output file specified, print to stdout (default: false)
* `:progress_report` - Report scan progress (default: true)
* `:quiet` - Suppress most messages (default: false)
* `:rails3` - Force Rails 3 mode (automatic)
* `:rails4` - Force Rails 4 mode (automatic)
* `:rails5` - Force Rails 5 mode (automatic)
* `:rails6` - Force Rails 6 mode (automatic)
* `:report_routes` - Show found routes on controllers (default: false)
* `:run_checks` - Array of checks to run (runs all default checks if not specified)
* `:safe_methods` - Array of methods to consider safe from XSS
* `:skip_libs` - Do not process lib/ directory (default: false)
* `:skip_files` - List of files/directories to skip
* `:skip_checks` - Checks not to run (run all if not specified)
* `:summary_only` - Only output summary section of report for plain/table (`:summary_only`, `:no_summary`, or `true`)

---

[More documentation](/docs)

---
layout: post
title: "Brakeman 1.6 Released"
date: 2012-04-20 10:22
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---


A lot of code has changed in this release, particularly with the removal of the Ruport library for reporting. While Ruport worked pretty well, it caused some issues just due to the large number of (out-dated) dependencies it brought with it. 

Also, this release changes the JSON report output. This is a backwards *incompatible* change. But, given how useless the previous JSON reports were, hopefully this will not affect too many people.

_Changes since 1.5.3:_

 * Remove the Ruport dependency (Neil Matatall)
 * Add more informational JSON output (Neil Matatall)
 * Add comparison to previous JSON report (Neil Matatall)
 * Add highlighting of dangerous values in HTML/text reports
 * `Model#update_attribute` should not raise mass assignment warning (Dave Worth)
 * Don't check `find_by_*` method for SQL injection
 * Fix duplicate reporting of mass assignment and SQL injection
 * Fix rescanning of deleted files
 * Properly check for `rails_xss` in Gemfile


### No More Ruport

Ruport is a nice library, but it also has not been updated in over two years and its dependency tree was ridiculous. 

Thanks to Neil Matatall, Brakeman no longer depends on Ruport, but the reports should look essentially the same. The HTML reports are now rendered through ERB templates, so it should not be too difficult to customize the reports if desired.

### Better JSON Output

JSON output now includes meta-information about the scan, errors raised during the scan, and line numbers for each warning.

### JSON Report Comparison

Being able to compare Brakeman reports is essential for tracking warnings over time. Prior to this release, the only decent way of doing that was via the [Jenkins plugin](http://brakemanscanner.org/docs/jenkins/). But now Brakeman can compare results to the JSON report from a previous scan.

For example:

    brakeman -o report.json
    brakeman --compare report.json

This will run another scan, then output a comparison of the reports (in JSON). The report includes a list of fixed warnings and a list of new warnings that were found.

### User Input Highlighted in Reports

Sometimes it is unclear exactly what value has caused Brakeman to issue a particular warning. This release adds highlighting the detected user input in most warnings. (Some warnings, the code that is reported *is* the detected user input). This information is also available in the JSON reports.

![User Input Highlight](/images/user_input_highlight.png "Example of User Input Highlighting")

### Fewer Mass Assignment and SQL Injection Methods

Dave Worth pointed out that Brakeman was a little overzealous in which methods it considered susceptible to mass assignment and SQL injection attacks.

Brakeman will no longer check `update_attribute` for mass assignment or the `find_by_*` dynamic methods for SQL injection.

### Fewer Mass Assignment and SQL Injection Duplicates

Pesky duplicate reports of mass assignment and SQL injection were turning up as template warnings. This occurred when the results of the mass assignment or SQL query were assigned to a variable which was then used in a template. This should now be fixed.

More details than are probably desired are available [here](https://github.com/presidentbeef/brakeman/pull/82).

### Rescanning Fixes

Rescanning of deleted files is now supported, and there some other issues with rescanning that are now resolved as well.

### New Logo

Brakeman has a sweet new logo, thanks to [Janelle Lawless](http://janellelawless.com/)!

![Brakeman Logo](/images/logo_medium.png)

Updates to the website to reflect this awesomeness are coming soon.

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

And don't forget to check out the Brakeman talk at [RailsConf](http://railsconf2012.com/sessions/44) in a few days.

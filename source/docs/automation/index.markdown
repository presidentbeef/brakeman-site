---
layout: docs
title: "Automation"
---

It is cumbersome to manually run Brakeman over and over.

Thankfully, Brakeman is designed to be run in an automated fashion.

The best output format to use with automation is JSON. Great care is taken to make sure the JSON format is stable.

    brakeman -o report.json

Note you can output multiple formats at the same time:

    brakeman -o report.json -o report.html

The exit codes for Brakeman can be helpful:

* 0 -	Everything was fine, no errors or issues
* 1 -	Unhandled exception raised
* 3 -	Warnings  were reported
* 4 -	Path did not look like a Rails application, no scan run
* 5 -	A newer version of Brakeman is available (when `--ensure-latest` is used)
* 6 -	Non-existent checks were specified
* 7 -	Recoverable errors encountered during scan
* 255 - Failure, non-recoverable error

## Tools

You can run Brakeman with:

* [Brakeman for Ruby LSP](https://github.com/presidentbeef/ruby-lsp-brakeman) (runs in LSP-compatible IDEs)
* [Guard::Brakeman](https://github.com/guard/guard-brakeman) (runs on file save)
* The [ALE](https://github.com/w0rp/ale) plugin for VIM (runs on file save)
* [Jenkins](/docs/jenkins) continuous integration tool

Documentation for setting up Brakeman in various CI tools:

* [Travis CI](https://rietta.com/blog/2017/10/03/automate-security-scans-with-continuous-integration/)
* [Semaphore CI](https://semaphoreci.com/community/tutorials/automatic-security-testing-of-rails-applications-using-brakeman)
* [Electric Cloud](https://electric-cloud.com/plugins/directory/p/brakeman/)
* [GitLab CI](https://medium.com/digital-banking-labs/setup-gitlab-ci-for-a-rails-application-ee38ea8c907d)


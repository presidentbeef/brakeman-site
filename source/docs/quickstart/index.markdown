---
layout: docs
title: "Quickstart"
date: 2018-09-24 11:49
comments: true
sharing: true
footer: true
---

### Introduction

Brakeman is a command-line tool that analyzes the source code of Ruby on Rails applications to find potential security vulnerabilities.

### Install Brakeman

Brakeman can be installed as a [Ruby gem](https://rubygems.org/) or via [Docker](https://www.docker.com/).

#### Using Rubygems

    gem install brakeman

#### Using Bundler

Add the following to your `Gemfile` or `gems.rb`:

    gem "brakeman"

Then run

    bundle install

#### Using Docker

To fetch the latest build of Brakeman:

    docker pull presidentbeef/brakeman

#### Building from Source

You will need Git, Ruby, and RubyGems installed.

    git clone https://github.com/presidentbeef/brakeman.git
    cd brakeman
    gem build brakeman.gemspec
    gem install brakeman-*.gem

### Run Brakeman

Brakeman is run as a command-line tool. The only information it needs to get started is the *root* directory of the Ruby on Rails application (the directory containing `app/`, `config/`, `db`, etc.) to scan.

#### Using Rubygems

Either specify the path to the root of your Ruby on Rails application:

    brakeman path/to/your/app

Or run it from the root of your Ruby on Rails application:

    cd path/to/your/app
    brakeman 

#### Using Docker

Either specify the path to the root of your Ruby on Rails application:

    docker run -v "path/to/your/app":/code brakeman --color

Or run it from the root of your Ruby on Rails application:

    cd path/to/your/app
    docker run -v "$(pwd)":/code brakeman --color

The `-v` option is necessary because the Ruby on Rails application needs to be mounted inside the Docker container.

The `--color` option is not required, but it makes the default report a little prettier.

### Reporting

The default report is text that looks like this:

![Brakeman Default Text Report](/images/brakeman_text_report.png)

To write the report out to a file, use `-o`:

    brakeman -o report.text

To specify a different format, use `-f`:

    brakeman -f html -o report

Or just use the extension of the report file:

    brakeman -o report.html

The available report types are:

* `text` (default)
* `html`
* `json` (recommended for automation)
* `junit` (JUnit XML)
* `markdown` (with GitHub support)
* `table` (old default)
* `tabs` (tab-separated, originally for the Jenkins plugin, deprecated)
* `csv` (deprecated)
* `codeclimate` (for use with the Code Climate engine)

### Next Steps

Once Brakeman is running and producting reports, it's time to start fixing those issues!

#### Remediation

Brakeman reports issues in order of "confidence". You can think of this as a combination of "how likely is this to be a problem?" and "how big of a problem is it?"

Start with the "High" confidence issues and work your way down.

Take a look at our [documentation about different warnings](/docs/warning_types/).

After fixing an issue, run Brakeman again. Sometimes one issue will mask a different one on the same line of code.

Keep in mind Brakeman can only *guess* at the meaning of your code. There is plenty of room for "false positives" - warnings reported that are not truly security issues. Please consult with your security team or [ask](/contact) if you are unsure about the meaning of a warning.

Take a look at [our documentation for ignoring warnings](https://brakemanscanner.org/docs/ignoring_false_positives/), if necessary.

#### Automation

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

##### Tools

You can run Brakeman with:

* [Guard::Brakeman](https://github.com/guard/guard-brakeman) (runs on file save)
* The [ALE](https://github.com/w0rp/ale) plugin for VIM (runs on file save)
* [Jenkins](/docs/jenkins) continuous integration tool
* Many [Brakeman-as-a-Service](https://github.com/presidentbeef/brakeman/wiki/Brakeman-as-a-Service) providers

Documentation for setting up Brakeman in various CI tools:

* [Travis CI](https://rietta.com/blog/2017/10/03/automate-security-scans-with-continuous-integration/)
* [Semaphore CI](https://semaphoreci.com/community/tutorials/automatic-security-testing-of-rails-applications-using-brakeman)
* [Electric Cloud](https://electric-cloud.com/plugins/directory/p/brakeman/)
* [GitLab CI](https://medium.com/digital-banking-labs/setup-gitlab-ci-for-a-rails-application-ee38ea8c907d)

### More Help

[Brakeman on GitHub](https://github.com/presidentbeef/brakeman/issues)

[Chat on Gitter](https://gitter.im/presidentbeef/brakeman)

---

[More documentation](/docs)

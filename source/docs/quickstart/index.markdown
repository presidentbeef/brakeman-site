---
layout: docs
title: "Quickstart"
date: 2018-09-24 11:49
comments: true
sharing: true
footer: true
---

## Introduction

Brakeman is a command-line tool that analyzes the source code of Ruby on Rails applications to find potential security vulnerabilities.

## Install Brakeman

Brakeman can be installed as a [Ruby gem](https://rubygems.org/) or via [Docker](https://www.docker.com/).

### Using Rubygems

    gem install brakeman

### Using Bundler

Add the following to your `Gemfile` or `gems.rb`:

    gem "brakeman"

Then run

    bundle install

### Using Docker

To fetch the latest build of Brakeman:

    docker pull presidentbeef/brakeman

### Building from Source

You will need Git, Ruby, and RubyGems installed.

    git clone https://github.com/presidentbeef/brakeman.git
    cd brakeman
    gem build brakeman.gemspec
    gem install brakeman-*.gem

## Run Brakeman

Brakeman is run as a command-line tool. The only information it needs to get started is the *root* directory of the Ruby on Rails application (the directory containing `app/`, `config/`, `db`, etc.) to scan.

### Using Rubygems

Either specify the path to the root of your Ruby on Rails application:

    brakeman path/to/your/app

Or run it from the root of your Ruby on Rails application:

    cd path/to/your/app
    brakeman 

### Using Docker

Either specify the path to the root of your Ruby on Rails application:

    docker run -v "path/to/your/app":/code brakeman --color

Or run it from the root of your Ruby on Rails application:

    cd path/to/your/app
    docker run -v "$(pwd)":/code brakeman --color

The `-v` option is necessary because the Ruby on Rails application needs to be mounted inside the Docker container.

The `--color` option is not required, but it makes the default report a little prettier.

## Reporting

The default report is text that looks like this:

![Brakeman Default Text Report](/images/brakeman_text_report.png)

To write the report out to a file, use `-o`:

    brakeman -o report.text

To specify a different format, use `-f`:

    brakeman -f html -o report

Or just use the extension of the report file:

    brakeman -o report.html

Additional report formats:

* `text` (default)
* `html`
* `json` (recommended for automation)
* `junit` (JUnit XML)
* `markdown` (with GitHub support)

## Remediation

Once Brakeman is running and producting reports, it's time to start fixing those issues!

Brakeman reports issues in order of "confidence". You can think of this as a combination of "how likely is this to be a problem?" and "how big of a problem is it?"

Start with the "High" confidence issues and work your way down.

Take a look at our [documentation about different warnings](/docs/warning_types/).

After fixing an issue, run Brakeman again. Sometimes one issue will mask a different one on the same line of code.

Keep in mind Brakeman can only *guess* at the meaning of your code. There is plenty of room for "false positives" - warnings reported that are not truly security issues. Please consult with your security team or [ask](/contact) if you are unsure about the meaning of a warning.

Take a look at [our documentation for ignoring warnings](/docs/ignoring_false_positives/), if necessary.

## Next Steps

* [Automating Brakeman](/docs/automation)
* [Configuring Brakeman](/docs/options)

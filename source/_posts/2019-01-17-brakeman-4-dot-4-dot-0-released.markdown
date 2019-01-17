---
layout: post
title: "Brakeman 4.4.0 Released"
date: 2019-01-17 13:14
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Happy new year and apologies for the delay in releases! Brakeman should now return to the normal 1-2 month release cycle. There are already pull requests lined up for the next release.

This release includes a number of fixes and new features. In particular, please note there are large changes to how reports and warning messages are generated. Please report any issues!

Also, the `brakeman` gem version of this release no longer supports use of Slim with Ruby 1.9.3. See below for details.

As noted previously, due to the [Synopsys acquisition](https://brakemanscanner.org/blog/2018/06/28/brakeman-has-been-acquired-by-synopsys/index.html) Brakeman is now distributed under a non-OSS license. See below for details.

_Changes since 4.3.1:_

* Add check for CVE-2018-3760
* Add `--enable` option to enable optional checks
* Add Dockerfile to run Brakeman inside Docker ([Ryan Kemper](https://github.com/ryankemper))
* Handle empty `secrets.yml` files ([Naoki Kimura](https://github.com/naokikimura))
* Ignore Tempfiles in FileAccess warnings ([Christina Koller](https://github.com/cmkoller))
* Avoid warning about command injection when `String#shellescape` and `Shellwords.shelljoin` are used ([George Ogata](https://github.com/oggy))
* Treat `if not` like `unless` ([#1225](https://github.com/presidentbeef/brakeman/issues/1225))
* Fix Rails 4 configuration handling 
* Set default encoding to UTF-8
* Support reading gem versions from gemspecs 
* Support gem versions which are just major.minor (e.g. 3.0)
* Correctly set `rel="noreferrer"` in HTML reports
* Fix thread-safety issue in CallIndex
* Fix trim mode for ERb templates in old Rails versions
* Avoid `nil` errors when concatenating arrays
* Add rendered template information to render paths
* Trim some unnecessary files from bundled gems
* Deadcode and typo fixes found via Coverity
* Complete overhaul of warning message construction
* Update to Slim 4.0.1 ([Jake Peterson](https://github.com/Jakenberg))
* Update to RubyParser 3.12.0
* Updated license

### CVE-2018-3760

A new check was added for [CVE-2018-3760](https://groups.google.com/d/msg/rubyonrails-security/ft_J--l55fM/7roDfQ50BwAJ) (Sprockets path traversal vulnerability).
Brakeman will warn about use of the affected Sprockets version and `config.assets.compile = true`.

([changes](https://github.com/presidentbeef/brakeman/pull/1241))

### Enable Optional Checks

Brakeman has options to enable *all* checks, to disable *some* checks, and to enable a subset of checks, but not to enable *default*+*some optional* checks.

The `--enable` option has been added to allow enabling individual optional checks.

([changes](https://github.com/presidentbeef/brakeman/pull/1263))

### Docker Support

Thanks to [Ryan Kemper](https://github.com/ryankemper), Brakeman now has a Dockerfile to enable local building and running of Brakeman inside Docker.

Additionally, there is now a [Docker image available for Brakeman](https://hub.docker.com/r/presidentbeef/brakeman):

    docker pull presidentbeef/brakeman
    docker run -v "$(pwd)":/code brakeman --color

See the Brakeman [README](https://github.com/presidentbeef/brakeman#running-with-docker) for more details.

Please note the Docker image is built from the master Brakeman branch. The master branch is typically stable, but it will typically be ahead of the gem release.

([changes](https://github.com/presidentbeef/brakeman/pull/1252))

### Empty Secrets

Thanks to [Naoki Kimura](https://github.com/naokikimura), Brakeman will no longer show an error when the `secrets.yml` file is empty.

([changes](https://github.com/presidentbeef/brakeman/pull/1254))

### File Access with Tempfiles 

Thanks to [Christina Koller](https://github.com/cmkoller), Brakeman will no longer warn about file access issues when Tempfiles are used.

([changes](https://github.com/presidentbeef/brakeman/pull/1244))

### Shellescape and Command Injection

Thanks to [George Ogata](https://github.com/oggy), Brakeman will no longer warn about command injection when `shelljoin` or `shellescape` are used.

([changes](https://github.com/presidentbeef/brakeman/pull/1242))

### Rails 4 Configuration

When implementing the check for CVE-2018-3760, it was discovered that Brakeman was not handling the Rails 4 configuration format properly:

Brakeman was not picking up any configuration options if this format was used:

```
<AppName>.application.configure do
  #...
end
``` 

([changes](https://github.com/presidentbeef/brakeman/pull/1241/commits/515a2f9e185f2488e227f39ed930ef6cf2bcee3a))

### Default Encoding

Brakeman now sets the default external encoding to `UTF-8` to avoid issues where the environment might set a different encoding.

([changes](https://github.com/presidentbeef/brakeman/pull/1288))

### Gem Versions

Brakeman can now read gem versions from `gemspec` files. This is common for Rails engines.

Additionally, Brakeman now understands versions which only specify major/minor versions (e.g. `~>4.0`).

The order of precedence is `Gemfile.lock` > `Gemfile` > `*.gemspec`.

([changes](https://github.com/presidentbeef/brakeman/pull/1257/))

### No Referrer in HTML Reports

Brakeman has unfortunately been setting `rel="no-referrer"` instead of `rel="noreferrer"` in HTML reports.

([changes](https://github.com/presidentbeef/brakeman/pull/1259/commits/d3e487bfd1d080971af56f7658bf2c8888e4cdb2))

### Thread-Safety in Call Index 

In rare cases (heavy CPU load?), accessing the CallIndex when running checks caused thread-unsafe behavior. This would have been reflected in a Ruby error about modifying the index during iteration, although checks don't actual modify the CallIndex. 

([changes](https://github.com/presidentbeef/brakeman/pull/1271))

### ERb Trim Mode

Brakeman has been accidentally setting the "trim mode" to the template file path (oops!) which silently (!) worked in tests. This only affects Rails 2.x.

This has been corrected and Ruby will now warn about [incorrect trim modes](https://redmine.ruby-lang.org/issues/15294).

([changes](https://github.com/presidentbeef/brakeman/pull/1278))

### Array Joins

This release fixes a `nil` error when attempting to concatenate arrays.

([changes](https://github.com/presidentbeef/brakeman/pull/1251))

### Rendered Template Information

Template "render paths" now include *which* template was rendered.

This is reflected in the JSON report:

```
      "render_path": [
        {
          "type": "controller",
          "class": "HomeController",
          "method": "test_to_json",
          "line": 148,
          "file": "app/controllers/home_controller.rb",
          "rendered": {
            "name": "home/test_to_json",
            "file": "app/views/home/test_to_json.html.erb"
          }
        }
      ]
```

In the future this information may be used to improve other report formats as well.

([changes](https://github.com/presidentbeef/brakeman/pull/1280)

### Reduced Gem Size

The `brakeman` gem [bundles all its dependencies](https://blog.presidentbeef.com/blog/2016/08/09/bundling-gem-dependencies-inside-ruby-gems/), which makes the gem a bit big.

This change removes some of the unneeded files (such as tests) and reduces the file size by about a third.

([changes](https://github.com/presidentbeef/brakeman/pull/1253))

### Dead Code and Typos

A few bits of dead code and minor typos were found via [Coverity](https://www.synopsys.com/software-integrity/security-testing/static-analysis-sast.html) and fixed. 

### Warning Message Overhaul

Brakeman warning messages were previously just strings.

In order to introduce some formatting flexibility, Brakeman warning messages are now constructed as arrays of `Message` objects.
These objects specify the type of the message string (e.g. "code" or "plain"). At report generation time, the messages can be converted to a particular format,
such as HTML, plaintext, etc.

Along with this change, quite a bit of cleanup was performed on report generation in general.

These changes make it easier to produce consistent messages as well as potentially supporting translation in the future.

You may notice warning message text and/or formatting has changed as a result of these changes.
Please report any issues.

([changes](https://github.com/presidentbeef/brakeman/pull/1259))

### Dependency Updates

Thanks to [Jake Peterson](https://github.com/Jakenberg), the Slim dependency has been updated to 4.0.1 to support newer syntax.

Note that Slim 4.x not longer supports Ruby 1.9.3. You may need to use the `brakeman-lib` gem or update your Ruby version.

([changes](https://github.com/presidentbeef/brakeman/pull/1285))

RubyParser has been updated to 3.12.0 which includes [some added syntax support and is faster!](https://github.com/seattlerb/ruby_parser/blob/master/History.rdoc#3120--2018-12-04)

<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr">Here are some example Brakeman scan times with the RubyParser improvements. <a href="https://t.co/yTxPVTGELH">pic.twitter.com/yTxPVTGELH</a></p>&mdash; Justin Collins (@presidentbeef) <a href="https://twitter.com/presidentbeef/status/1068232020478717952?ref_src=twsrc%5Etfw">November 29, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

([changes](https://github.com/presidentbeef/brakeman/pull/1286))

### New License

Brakeman is now distributed under the [Brakeman Public Use License](https://github.com/presidentbeef/brakeman/blob/master/LICENSE.md) which restricts commercial use of Brakeman.

It does not restrict use of Brakeman to scan *your own code* or your organization's code, regardless of whether that code is proprietary, commercial, free, open source, etc.

Feel free to message [@presidentbeef](https://twitter.com/presidentbeef) if you have questions.

([changes](https://github.com/presidentbeef/brakeman/pull/1301))

### Checksums

The SHA256 sums for this release are:

    d3204cfe9d26782954ee8805fd748d11e8f950d2c1aee7c806c1856f273ee3b9  brakeman-4.4.0.gem
    88849f05b1c85756fee8974b8061383493714676187af3b94b6a7978a7e1e58d  brakeman-lib-4.4.0.gem
    0417c20b0b6dab00c5cf5e9341868dc5d8139bca463bf45fefa925cac286127e  brakeman-min-4.4.0.gem

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


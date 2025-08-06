---
layout: blog
title: Brakeman 6.2.1 Released
date: 2024-08-22 10:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 6.1.2
  changes:
  - Add optional support for Prism parser
  - Handle parallel assignment with splats ([#1833](https://github.com/presidentbeef/brakeman/issues/1833))
  - Warn about unscoped finds with `find_by!` ([#1786](https://github.com/presidentbeef/brakeman/issues/1786))
  - Add initial Rails 8 support ([Ron Shinall](https://github.com/ron-shinall))
  - Add support for symbolic links ([Lu Zhu](https://github.com/lubert))
  - Support YAML aliases in secret configs ([Chedli Bourguiba](https://github.com/chaadow))
  - Add `--show-ignored` option ([Gabriel Arcangel Zayas](https://github.com/gazayas))
  - Treat `::X` and `X` the same, for now ([Jill Klang](https://github.com/that-jill))
  - Remediation advice for command injection [Nicholas Barone](https://github.com/rangerscience)
  - Fix compatibility with default frozen string literals ([Jean Boussier](https://github.com/casperisfine))
  - Fix Ruby warnings in test suite ([Jean Boussier](https://github.com/casperisfine))
checksums:
- hash: 862e709caa1abf00dd0c47045682404c349f64876c7be74a8e6a4d6be5f61a1d
  file: brakeman-6.2.1.gem
- hash: 7c3b5268a83d53069b778056624e5f215d17f24902ca7f381299c2ba7dc7b684
  file: brakeman-lib-6.2.1.gem
- hash: cb839d5f1e0d356c33141dda377f401712a89e4d501748f1c01faa41c9d0f70e
  file: brakeman-min-6.2.1.gem
---


Lots of great contributions in this release, thanks!


_What happened to 6.2.0? Packaging issue! No other changes._

## Optional Support for Prism Parser

[Prism](https://ruby.github.io/prism/) is a new Ruby parsing library which is intended to bring together all the various Ruby parsing libraries together.

This release adds optional support for the Prism parser.

To enable use of Prism, install it directly or add it to your `Gemfile`. Then enable it with `--prism`.

([changes](https://github.com/presidentbeef/brakeman/pull/1858))

## Parallel Assignment with Splats 

Support splats in parallel assignments like

```ruby
a, *b = 1, 2, 3
```

([changes](https://github.com/presidentbeef/brakeman/pull/1843))

## Unscoped Finds with `find_by!`

Warn about insecure direct object references in code using `find_by!`:

```ruby
User.find_by!(id: params[:id])
```

([changes](https://github.com/presidentbeef/brakeman/pull/1859))

## Initial Rails 8 Support

While there is no specific behavior added yet for Rails 8, Brakeman will detect it properly and the `-8`/`--rails8` options have been added.

Thanks to [Ron Shinall](https://github.com/ron-shinall) for proactively adding this functionality.

([changes](https://github.com/presidentbeef/brakeman/pull/1846))


## Support for Symbolic Links

Thanks to [Lu Zhu](https://github.com/lubert), Brakeman will now follow symbolic links for directories - in particular links to files outside of the root directory of the Rails application.

([changes](https://github.com/presidentbeef/brakeman/pull/1828))

## YAML Aliases in Secrets Config

[Chedli Bourguiba](https://github.com/chaadow) enabled support for use of aliases in secrets configuration files.

([changes](https://github.com/presidentbeef/brakeman/pull/1847))

## Option to Show Ignored Warnings in Text Report

In response to [this request](https://github.com/presidentbeef/brakeman/issues/1767), [Gabriel Arcangel Zayas](https://github.com/gazayas) added the `--show-ignored` option to
list ignored warnings in the default text report.

![Ignored warnings in text report](/images/ignored_warnings_example.png)

([changes](https://github.com/presidentbeef/brakeman/pull/1861))

## Top-Level Constants

While it may be semantically incorrect, Brakeman will now treat `::Foo` and `Foo` the same. This helps when matching against known constants like `ViewComponent::Base` and `::ViewComponent::Base`. Thanks to [Jill Klang](https://github.com/that-jill) for addressing this one.

([changes](https://github.com/presidentbeef/brakeman/pull/1838))

## Remediation Advice for Command Injection

[Nicholas Barone](https://github.com/rangerscience) added a note about using `shellescape` to make shell commands safer.

([changes](https://github.com/presidentbeef/brakeman/pull/1852))

## Frozen String Support

([Jean Boussier](https://github.com/casperisfine)) has made Brakeman compatible with use of Ruby's frozen string literals (e.g. `--enable-frozen-string-literal`), avoiding any future issues if/when frozen strings are the default.

Along the way, they also fixed up some Ruby warnings in the test suite.

([changes](https://github.com/presidentbeef/brakeman/pull/1855))


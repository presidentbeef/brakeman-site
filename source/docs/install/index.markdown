---
layout: page
title: "Installing Brakeman"
date: 2011-08-26 23:18
comments: false
sharing: false
footer: true
---

### gem install

Brakeman is best installed via [RubyGems](http://rubygems.org/):

    gem install brakeman

This will provide the `brakeman` executable.

### bundler

Brakeman can be added to a Gemfile:

    gem "brakeman"

It is recommended to _always_ use the latest version of Brakeman.

### git clone

If you must have the latest and greatest, then you can build the gem yourself:

    git clone git://github.com/presidentbeef/brakeman.git
    cd brakeman
    gem build brakeman.gemspec
    gem install brakeman-*.gem

---
[Running Brakeman](/docs/running)

[More documentation](/docs)

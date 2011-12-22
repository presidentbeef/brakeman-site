---
layout: page
title: "Installing Brakeman"
date: 2011-08-26 23:18
comments: false
sharing: false
footer: true
---

Brakeman is best installed via [RubyGems](http://rubygems.org/):

    gem install brakeman

This will provide the `brakeman` executable.

If you must have the latest and greatest, then you can build the gem yourself:

    git clone git://github.com/presidentbeef/brakeman.git
    cd brakeman
    gem build brakeman.gemspec
    gem install brakeman-*.gem

---
[Running Brakeman](/docs/running)

[More documentation](/docs)

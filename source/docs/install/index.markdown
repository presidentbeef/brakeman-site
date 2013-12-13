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

Brakeman gems are now signed, which means the contents of the gem can be verified using the [public Brakeman certificate](https://github.com/presidentbeef/brakeman/blob/master/brakeman-public_cert.pem).

To verify the gem, first add the certificate as "trusted":

    gem cert --add <(curl -Ls https://raw.github.com/presidentbeef/brakeman/master/brakeman-public_cert.pem)

If that looks scary, the certificate can always be downloaded manually and then added. The certificate only needs to be added once.

Then the gem can be verified at install:

    gem install brakeman -P MediumSecurity

"HighSecurity" cannot be used at this time since it requires all dependencies to also be signed by their authors.

### bundler

Brakeman can be added to a Gemfile:

    gem "brakeman", :require => false

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

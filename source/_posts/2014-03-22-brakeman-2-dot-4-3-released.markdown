---
layout: blog
title: "Brakeman 2.4.3 Released"
date: 2014-03-22 17:49
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

A new gem version has been released because the 2.4.2 gem was not signed. No other changes were introduced.

## Signed Gems

As a reminder, the Brakeman gems are (supposed to be) signed and can be verified with [this certificate](https://github.com/presidentbeef/brakeman/blob/master/brakeman-public_cert.pem).

To verify on installation:

    gem cert --add <(curl -Ls https://raw.github.com/presidentbeef/brakeman/master/brakeman-public_cert.pem)
    gem install brakeman -P MediumSecurity

"HighSecurity" requires all dependencies to be signed as well, which is unlikely.

There is some weirdness around `-P MediumSecurity` currently. The simplest solution seems to be:

    gem install brakeman   # Install Brakeman and all dependencies
    gem uninstall brakeman # Remove the Brakeman gem
    gem install brakeman -P MediumSecurity  # Install Brakeman gem and check signature

## SHAs

The SHA1 sums for this release are

    16b4890fa8ee6bad1d429a12bf3f0cb8e76cb2d8  brakeman-2.4.3.gem
    be5743d77140e64b75eefc53f8697f767ab370d9  brakeman-min-2.4.3.gem 

## Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/). 

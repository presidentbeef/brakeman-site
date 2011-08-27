---
layout: post
title: "One Year Anniversary and a Website"
date: 2011-08-27 01:00
comments: true
categories: 
---

One year ago, Brakeman 0.0.1 was released as a gem. Then it was promptly yanked and replaced with [Brakeman 0.0.2](http://rubygems.org/gems/brakeman/versions/0.0.2).

In celebration of this grand anniversary, there have been several new releases today.

The first is [Brakeman 0.7.2](http://rubygems.org/gems/brakeman/versions/0.7.1), a minor release adding CVE numbers for the [latest vulnerabilities](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/f878a33159ac9967) and fixing how nested params/cookie accesses are handled (e.g., `params[:user][:name]` is now considered a direct use of a parameter).

Next up, Brakeman has its own Twitter feed [@BrakemanScanner](https://twitter.com/brakemanscanner).

Lastly, there is this new website. Look forward to tutorials and more in-depth information about how to use Brakeman effectively.

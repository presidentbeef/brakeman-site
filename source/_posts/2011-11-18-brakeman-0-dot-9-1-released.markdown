---
layout: blog
title: "Brakeman 0.9.1 Released"
date: 2011-11-18 10:41
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---

[A new vulnerability was disclosed](http://groups.google.com/group/rubyonrails-security/browse_thread/thread/2b61d70fb73c7cc5) yesterday in the Rails [translate helper](http://api.rubyonrails.org/classes/ActionView/Helpers/TranslationHelper.html#method-i-translate).

This vulnerability affects Rails 2.3.x when using the rails_xss plugin, Rails 3.0 - 3.0.10, and Rails 3.1 - 3.1.1.

The only change in the 0.9.1 release is a check for this new vulnerability.

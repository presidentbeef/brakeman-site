---
layout: page
title: "Format Validation"
date: 2011-11-10 12:44
comments: false
sharing: true
footer: true
---

Calls to `validates_format_of ..., :with => //` which do not use `\A` and `\z` as anchors will cause this warning. Using `^` and `$` is not sufficient, as they will only match up to a new line. This allows an attacker to put whatever malicious input they would like before or after a new line character.

See [the Ruby Security Guide](http://guides.rubyonrails.org/security.html#regular-expressions) for details.

---
Back to [Warning Types](/docs/warning_types)

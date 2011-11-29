---
layout: post
title: "Brakeman 0.9.2 Released"
date: 2011-11-21 17:12
comments: true
categories: 
---

Changes:

 * Fix Rails 3 configuration parsing
 * Check both t() and translate() for cross-site scripting bug

Just a small release to get the Rails 3 config fix out.

### Rails 3 Configuration Parsing

There was an issue that would cause Brakeman to crash on certain configurations. This has been fixed.

### Look for t()

Both the `translate` and its shorter alias `t` will cause the warning about the cross-site scripting bug in them to be set to high confidence. If neither of these functions are found in the application, the confidence is set to medium.

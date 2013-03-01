---
layout: page
title: "Authentication Whitelist"
date: 2013-03-01 11:33
comments: true
sharing: true
footer: true
---

When skipping `before_filter`s with security implications, a "whitelist" approach using `only` should be used instead of `except`. This ensures actions are protected by default, and unprotected only by exception.

---
Back to [Warning Types](/docs/warning_types)

---
layout: page
title: "Weak Hash"
comments: false
sharing: true
footer: true
---

Brakeman reports a "Weak Hash" warning when it finds uses of hashing algorithms that should not be used for security-sensitive contexts
such as hashing passwords or generating signatures.

Currently, Brakeman warns about the use of SHA1 and MD5, which should not be used for anything outside of interacting with Git.

The confidence level of a "Weak Hash" warning is based on whether the value being hash looks like user-controlled input or a password.

---
Back to [Warning Types](/docs/warning_types)

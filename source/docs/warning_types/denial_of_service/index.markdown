---
layout: page
title: "Denial of Service"
date: 2013-05-16 12:47
comments: false
sharing: true
footer: true
---

Denial of Service (DoS) is any attack which causes a service to become unavailable for legitimate clients.

For issues that Brakeman detects, this typically arises in the form of memory leaks. In particular, since Symbols are not garbage collected, creation of large numbers of Symbols could lead to a server running out of memory.

Brakeman checks for instances of user input which is converted to a Symbol. When this is not restricted, an attacker could create an unlimited number of Symbols.

---

Back to [Warning Types](/docs/warning_types)

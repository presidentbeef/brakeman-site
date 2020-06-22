---
layout: page
title: "Denial of Service"
date: 2013-05-16 12:47
comments: false
sharing: true
footer: true
---

Denial of Service (DoS) is any attack which causes a service to become unavailable for legitimate clients.

Denial of Service can be caused by consuming large amounts of network, memory, or CPU resources.

### Regex DoS

If an attacker can control the content of a regular expression, they may be able to construct a regular expression that requires exponential time to run.

Brakeman will warn about dynamic regular expressions that inject user-supplied values.

For example:

    some.values.any? { |v| v.match /#{params[:query]}/ }

More information:

* [ReDoS](https://en.wikipedia.org/wiki/ReDoS)
* [Catastrophic Backtracking](https://www.regular-expressions.info/catastrophic.html)
* [Regular Expression Matching Can Be Simple And Fast](https://swtch.com/~rsc/regexp/regexp1.html)

### Symbol DoS

[Prior to Ruby 2.2](https://www.ruby-lang.org/en/news/2014/12/25/ruby-2-2-0-released/), Symbols were not garbage collected. Creation of large numbers of Symbols could lead to a server running out of memory.

If the application appears to be using an older version of Ruby, Brakeman checks for code where user input which is converted to a Symbol. When this is not restricted, an attacker could create an unlimited number of Symbols.

Note: This is an optional check which can be enabled with `--enable SymbolDoS` or `--run-all-checks`.

---

[More Information](https://owasp.org/www-community/attacks/Denial_of_Service)

Back to [Warning Types](/docs/warning_types)

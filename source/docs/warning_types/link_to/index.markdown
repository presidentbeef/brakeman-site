---
layout: page
title: "Cross Site Scripting: link\_to"
date: 2012-07-11 11:36
comments: false
sharing: true
footer: true
---

In the 2.x versions of Rails, `link_to` would not escape the body of the HREF.

For example, this will popup an alert box:

    link_to "<script>alert(1)</script>", "http://google.com"

Brakeman warns on cases where the first parameter contains user input.

---
Back to [Warning Types](/docs/warning_types)

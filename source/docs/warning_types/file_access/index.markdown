---
layout: page
title: "File Access"
date: 2011-11-10 16:06
comments: false
sharing: true
footer: true
---

Using user input when accessing files (local or remote) will raise a warning in Brakeman.

For example

    File.open("/tmp/#{cookie[:file]}")

will raise an error like

    Cookie value used in file name near line 4: File.open("/tmp/#{cookie[:file]}")

This type of vulnerability can be used to access arbitrary files on a server (including `/etc/passwd`.

---
Back to [Warning Types](/docs/warning_types)

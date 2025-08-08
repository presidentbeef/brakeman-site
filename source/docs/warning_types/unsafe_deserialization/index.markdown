---
layout: docs
title: "Unsafe Deserialization"
date: 2013-05-17 14:37
comments: false
sharing: true
footer: true
---

Objects in Ruby may be serialized to strings. The main method for doing so is the built-in `Marshal` class. The `YAML`, `JSON`, and `CSV` libraries also have methods for dumping Ruby objects into strings, and then creating objects from those strings.

Deserialization of arbitrary objects can lead to [remote code execution](/docs/warning_types/remote_code_execution), as was demonstrated with [CVE-2013-0156](https://groups.google.com/d/msg/rubyonrails-security/61bkgvnSGTQ/nehwjA8tQ8EJ). 

Brakeman warns when loading user input with `Marshal`, `YAML`, or `CSV`. `JSON` is covered by the checks for [CVE-2013-0333](https://groups.google.com/d/msg/rubyonrails-security/1h2DR63ViGo/GOUVafeaF1IJ)

---
Back to [Warning Types](/docs/warning_types)

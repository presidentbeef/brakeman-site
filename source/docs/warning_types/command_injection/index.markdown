---
layout: page
title: "Command Injection"
date: 2011-11-09 14:33
comments: false
sharing: true
footer: true
---

Injection is #1 on the 2010 [OWASP Top Ten](https://web.archive.org/web/20190223031311/https://www.owasp.org/index.php/Top_10_2010-A1) web security risks. Command injection occurs when shell commands unsafely include user-manipulatable values.

There are many ways to run commands in Ruby:

    `ls #{params[:file]}`

    system("ls #{params[:dir]}")

    exec("md5sum #{params[:input]}")

Brakeman will warn on any method like these that uses user input or unsafely interpolates variables.

See [the Ruby Security Guide](http://guides.rubyonrails.org/security.html#command-line-injection) for details.

---
Back to [Warning Types](/docs/warning_types)


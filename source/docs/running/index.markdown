---
layout: page
title: "Running Brakeman"
date: 2011-08-27 08:08
comments: false
sharing: false
footer: true
---

The simplest way to get started with Brakeman is to just run it with no options in the root directory of your Rails application:

    cd your_rails_app/
    brakeman

This will scan the application in the current directory and output a report to the command line.

Alternatively, you can supply a path as an option to Brakeman:

    brakeman your_rails_app

---
[Brakeman Options](/docs/options)

[More documentation](/docs)

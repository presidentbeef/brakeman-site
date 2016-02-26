---
layout: page
title: "Parsing Errors"
date: 2012-06-22 09:34
comments: false
sharing: true
footer: true
---

Brakeman relies on [ruby\_parser](https://github.com/seattlerb/ruby_parser) for parsing Ruby code.

The steps below should help narrow down the source of the problem.

### Check Ruby Syntax

If the file is a Ruby file, then the syntax can be checked directly.

Run `ruby -c` against the file that caused the error to check the syntax of the file using the Ruby interpreter.

Run `ruby_parse` against the file that caused the error to check the syntax of the file using ruby\_parser.

### Check ERB Output

If the file is an ERB template, then the output of `erb` or `erubis` must be checked.

Run `erubis -x file_name.html.erb | ruby -c` to check using Erubis.

_Important:_ Rails uses a slightly modified version of ERB, so the output from these tools is not exactly the same as what Rails sees. Brakeman attempts to emulate the Rails version.

### Check Haml Output

If the file is a Haml template, then the output of `haml` needs to be checked.

Run `haml -e --debug file_name.html.haml` to check the output. Note that this will attempt to execute the code, which will likely fail. However, it will also indicate syntax problems.

### File an Issue

Please file [an issue](https://github.com/presidentbeef/brakeman/issues) with an example of the syntax which fails to parse.

---

[Other Problems](/docs/troubleshooting)

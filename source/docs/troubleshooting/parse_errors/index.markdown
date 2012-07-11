---
layout: page
title: "Parsing Errors"
date: 2012-06-22 09:34
comments: false
sharing: true
footer: true
---

Brakeman relies on [ruby\_parser](https://github.com/seattlerb/ruby_parser) for parsing Ruby code. Support for Ruby 1.9 syntax is still in development, so Brakeman cannot handle all the new 1.9 syntax changes. Unfortunately, the next version of ruby\_parser (3.0) makes some large, incompatible changes which will also require major changes in Brakeman. This means some syntax may go unsupported for a while.

The steps below should help narrow down the source of the problem.

### Check Ruby Syntax

If the file is a Ruby file, then the syntax can be checked directly.

Run `ruby -c` against the file that caused the error to check the syntax of the file using the Ruby interpreter.

Run `ruby_parse` against the file that caused the error to check the syntax of the file using ruby\_parser.

### Check ERB Output

If the file is an ERB template, then the output of `erb` or `erubis` must be checked.

Run `erb -x file_name.html.erb | ruby -c` to check using ERB.

Run `erubis -x file_name.html.erb | ruby -c` to check using Erubis. Use this for Rails 3 or when using the `rails_xss` gem.

_Important:_ Rails uses a slightly modified version of ERB, so the output from these tools is not exactly the same as what Rails sees. Brakeman attempts to emulate the Rails version.

### Check Haml Output

If the file is a Haml template, then the output of `haml` needs to be checked.

Run `haml -e --debug file_name.html.haml` to check the output. Note that this will attempt to execute the code, which will likely fail. However, it will also indicate syntax problems.

### Remove Ruby 1.9 Syntax

If the file contains Ruby 1.9 syntax, try changing it to 1.8 syntax. If this resolves the problem, then it is definitely a ruby\_parse issue. Note, however, that it may already be fixed in the master branch.

### File an Issue

Please file [an issue](https://github.com/presidentbeef/brakeman/issues) with an example of the syntax which fails to parse. While these are usually ruby\_parser problems, it never hurts to look into it.

---

[Other Problems](/docs/troubleshooting)

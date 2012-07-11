---
layout: page
title: "Brakeman Hangs"
date: 2012-06-22 09:34
comments: false
sharing: true
footer: true
---

Sometimes Brakeman appears to "hang" while processing. Memory usage typically climbs until it has exhausted all resources.

The steps below should help pinpoint the problem.

### Run in Debug Mode

Run Brakeman with the `-d` option which will output the name of each file as it is processed.

This usually pinpoints a single file which is causing the problem. In rare cases, Brakeman might be looping between two files.

Additionally, the `-d` option will cause Brakeman to output a stack trace when the process is stopped with an interrupt (e.g., pressing Ctrl-c).

### Run in 'Fast' Mode

Run Brakeman with the `--fast` option to turn off some features which have historically had some problems.

In particular, if Brakeman appears to hang while processing "data flow", this may be an issue with how branching in `if` statements is handled.

### Skip Problem Files

Run Brakeman with `--skip-files` and skip the file(s) which is suspected of causing the hang.

If this works, then the problem is definitely narrowed down to that file(s).

### Report an Issue

Please file [an issue](https://github.com/presidentbeef/brakeman/issues) so the problem can be fixed. Include a stack trace and, if possible, the contents of the file. The file can also be shared privately.

---

[Other Problems](/docs/troubleshooting)

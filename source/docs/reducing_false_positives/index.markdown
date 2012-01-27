---
layout: page
title: "Reducing False Positives"
date: 2012-01-10 10:23
comments: false
sharing: false
footer: true
---

By default, Brakeman reports as much as possible. Because there is no way for Brakeman to know if certain items are actually safe or not, it errs on the side of reporting _too much_ rather than possibly not reporting a real problem. Sometimes, though, these false positives can become overwhelming. While there is no method currently for marking a specific warning as a false positive, Brakeman does provide options for customizing reports.

It is recommended to always run Brakeman with the default settings first (and then periodically after that), but it is possible to narrow down the results to make them less annoying.

### Specify Checks to Run

When running Brakeman, one can specify a set of checks to run or a set to exclude using the `--test` or `--except`, respectively. These options take a comma-separated list of check names, which are case-sensitive. Use `brakeman --checks` to get a list of the exact check names.

For example, to only check for SQL injection and cross-site scripting:

    brakeman --test CheckSQL,CheckCrossSiteScripting

_('Check' can actually be omitted from the names.)_

To exclude checks for dynamic render paths:

    brakeman --except CheckRender

### Set Confidence Threshold

Getting a ton of weak confidence warnings? Use `-w3` to only report high confidence warnings or `-w2` to only report high and medium confidence warnings.

(Use of `-w3` is not recommended, however.)

### Mark Methods as Safe

If an applications has custome sanitizing methods or just methods which are known to be safe, then the `--safe-methods` option can be used to ignore those methods. Specify the methods as a comma-separated list.

For example:

    brakeman --safe-methods this_one,that_one,totally_safe,my_sanitizer

### Only Reporting Direct Vulnerabilities

With the default settings, Brakeman will report cross-site scripting vulnerabilities if the return value of a method where user input is a _parameter_ is output.

For example, this will raise a warning unless `some_method` is marked as safe like above:

    <%= some_method(params[:blah]) %>

To ignore this kind of output, use the `--report-direct` option. This also applies to some other situations, such as checking calls to `redirect_to`.

### Ignoring Model Attributes

Brakeman assumes database values are suspect (and so should you). But for some applications this does not make sense. Use the `--ignore-model-output` option to suppress reporting model attributes as cross-site scripting vulnerabilities.

---

[More documentation](/docs)

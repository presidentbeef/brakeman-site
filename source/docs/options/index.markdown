---
layout: page
title: "Options"
date: 2011-08-27 08:08
comments: false
sharing: false
footer: true
---

### Output Options

**Output File**

To specify an output file for the results:

    brakeman -o output_file

**Output Format**

The output format is determined by the file extension used with the `-o` option or by using the `-f` option. Current options are: `text`, `html`, `tabs`, and `csv`.

For example, to output an HTML report:

    brakeman -o report.html

**Message Length**

By default, brakeman truncates warning messages to 100 characters. The `--message-limit` option can be used to adjust this. Setting the limit to `-1` will disable truncation completely.

**Quiet Operation**

To suppress informational warnings and just output the report:

    brakeman -q

**Debugging Information**

To see all kinds of debugging information:

    brakeman -d

### Scanning Options

**Specify Path to Application**

Usually the path to the Rails app is the last argument. Optionally, the `--path` option can be used to specify a path.

**Manually Turn on XSS Protection**

If you are using the `rails_xss` gem or some other plugin, but Brakeman is not detecting it, the `--escape-html` option will use Erubis for rendering ERB files and turn on HTML escaping for ERB and HAML.

**Manually Turn on Rails 3 Support**

Brakeman should detect Rails 3 applications, but if not the `-3` will switch Brakeman to Rails 3 mode.

**Specifying Which Checks to Run**

Specific checks can be skipped, if desired. The name needs to be the correct case. For example, to skip looking for default routes (`DefaultRoutes`):

    brakeman -x DefaultRoutes

Multiple checks should be separated by a comma:

    brakeman -x DefaultRoutes,Redirect

To do the opposite and only run a certain set of tests:

    brakeman -t SQL,ValidationRegex

**Report Routes**

To see what actions brakeman has detected as being routes, use the `--routes` option.

### Warning Options

**Ignore Safe Methods**

To indicate certain methods are "safe":

    brakeman -s benign_method,totally_safe

**Assume Unknown Methods are Safe**

By default, brakeman will assume that unknown methods involving untrusted data are dangerous. For example, this would raise a warning (in Rails 2.x):

    <%= some_method(:option => params[:input]) %>

To only raise warnings only when untrusted data is being directly used:

    brakeman -r

**Ignore Model Output**

By default, brakeman will report unescaped model attributes as dangerous. To disregard these warnings, use `--ignore-model-output`.

**Set Minimum Confidence Level**

To only report warnings at or above a certain confidence level, use the `-w` option.

1. Weak confidence
2. Medium confidence
3. High confidence

For example, to only show high confidence warnings:

    brakeman -w3

See [confidence levels](/docs/confidence) for more information.

---

[More documentation](/docs)

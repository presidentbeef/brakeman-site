---
layout: blog
title: Brakeman 1.8.0 Released
date: 2012-09-04 11:26
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.7.1
  changes:
  - " * Support relative paths in reports (fsword)"
  - " * Allow Brakeman to be run without tty (fsword)"
  - " * Fix exit code with `--compare` (fsword)"
  - " * Fix `--rake` option (Deepak Kumar)"
  - " * Add high confidence warnings for `to_json` XSS (Neil Matatall)"
  - " * Fix `redirect_to` false negative"
  - " * Fix duplicate warnings with `raw` calls"
  - " * Fix shadowing of rendered partials"
  - ' * Add "render chain" to HTML reports'
  - " * Add check for XSS in `content_tag`"
  - " * Add full backtrace for errors in debug mode"
  - " * Treat model attributes in `or` expressions as immediate values"
  - " * Switch to method access for Sexp nodes"
---




## Relative Paths in Reports

The `--relative-paths` option will now cause Brakeman to output relative paths for warnings in reports in either JSON or tabs format. This is useful when comparing reports run on different machines or just in different directories.

## Brakeman without TTY

Thanks to [fsword](http://fsword.github.com/), Brakeman can now run without a TTY available.

## Exit Code for Compare

Also thanks to fsword, Brakeman will return a proper exit code when run with `-z --compare`. If any changes are found, the exit code will be nonzero.

## Rake Task Generation Fixed

The `--rake` option was broken, but [Deepak Kumar](https://github.com/deepakinseattle) noticed and fixed it!

## High Confidence Warnings for JSON

Older versions of Rails default to not escaping `to_json` calls, leading to [cross site scripting problems](http://brakemanscanner.org/docs/warning_types/cross_site_scripting_to_json/). Since Rails 2.1.0, Rails has provided an option to escape JSON output by default. Brakeman will check this option, and warn on unescaped `to_json` calls. 

## Fix Redirect False Negative

Brakeman was incorrectly checking for `:only_path => true` in *any* argument to `redirect_to`. However, it is only valid as part of the first argument.

## Fix Duplicate Warnings on Raw Calls

A logic mistake sometimes caused a high and weak confidence warning to be reported for the same code using `raw`. This has been fixed.

## Fix Shadowing of Rendered Partials

Due to the way Brakeman was storing rendered partials, a view that was rendered multiple times via different code paths would only store a single instance of the rendered view. This could result in some vulnerabilities not being reported.

To fix this, Brakeman now stores the entire "render chain" (that is, each location of a `render`). This ensures a unique key for each rendered template.

## Report Render Chain in HTML

HTML reports now have a new feature that reports the "render chain" for view warnings (if the chain is more than a single call deep).

A warning like this:

![Unexpanded](/images/unexpanded_call_chain.png)

Might expand to show this chain:

![Expanded](/images/expanded_call_chain.png)

## Check for XSS in `content_tag`

`content_tag` is a view helper for generating HTML tags containing some content. In Rails 2.x, `content_tag` did not escape this content. In Rails 3.x, this changed so that now it is escaped. While `content_tag` does have an `escape` parameter (true by default), this only applies to the tag attribute *values*.

Brakeman now warns on possible cross site scripting via `content_tag` calls. [See here](/docs/warning_types/content_tag) for more details.

## Backtraces in Debug Mode

By default, Brakeman tries its best to recover from errors and produce a report. However, this can sometimes make it difficult to track down the sources of errors. Now, with the `-d` option, Brakeman will report backtraces for errors encountered while running, as well as including backtraces in HTML reports.

## Convenience Methods for Sexp Access

Previously, all code dealing with [s-expressions](https://en.wikipedia.org/wiki/S-exp) in the `Sexp` class accessed nodes via array access, e.g. `exp[1]` or `exp[2]`. This led to hard-to-read code like `exp[2][3][1][1..-1]`. This release includes convenience methods to replace those types of calls. Available methods are [documented here](http://rdoc.info/gems/brakeman/Sexp).

Hopefully this leads to code that is both easier to read and easier to write.

## Reporting Problems

This release touches a lot of code (76 changed files with 1,515 additions and 598 deletions), so there is ample opportunity for bugs to sneak in. Please report any [issues](https://github.com/presidentbeef/brakeman/issues)!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) and following [@brakeman](https://twitter.com/brakeman) on Twitter. 

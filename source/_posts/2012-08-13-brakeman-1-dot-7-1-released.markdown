---
layout: blog
title: Brakeman 1.7.1 Released
date: 2012-08-13 11:04
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 1.7.0
  changes:
  - " * Add check for [CVE-2012-3463](https://groups.google.com/d/topic/rubyonrails-security/fV3QUToSMSw/discussion)"
  - " * Add check for [CVE-2012-3464](https://groups.google.com/d/topic/rubyonrails-security/kKGNeMrnmiY/discussion)"
  - " * Add check for [CVE-2012-3465](https://groups.google.com/d/topic/rubyonrails-security/FgVEtBajcTY/discussion)"
  - " * Add charset to HTML report ([hooopo](https://github.com/hooopo))"
  - " * Report XSS in select() for Rails 2"
---


This is a small release to add checks for the [Rails vulnerabilities reported last week](http://weblog.rubyonrails.org/2012/8/9/ann-rails-3-2-8-has-been-released/).


## CVE-2012-3463 - XSS in select\_tag Prompt

In Rails 3.x, values supplied to the `:prompt` option in the `select_tag` helper are not escaped, leading to a cross-site scripting vulnerability.

Brakeman will warn on all uses of `select_tag` with unescaped user input in the `:prompt` option.

## CVE-2012-3464 - Single Quotes are Unescaped

This is pretty much a known issue ([example from 2008](http://www.ruby-forum.com/topic/166894)), but Rails 3.2.8 fixes it.

Single quotes are most dangerous when interpolating values into HTML attributes that use single quotes, which is why it is often recommended to always use double quotes in HTML.

There is a [provided workaround](https://groups.google.com/d/topic/rubyonrails-security/kKGNeMrnmiY/discussion) for earlier versions of Rails which replaces `ERB::Util.html_escape` with `Rack::Utils.escape_html`. This method adds escaping for both single quotes (`'`) and forward slashes (`/`).

If the provided workaround is used in an initializer, as suggested, then Brakeman will not generate a warning for this vulnerability. Otherwise, Brakeman will generate a warning for affected versions.

## CVE-2012-3465 - XSS in strip\_tags

Another vulnerability has been reported for `strip_tags` (earlier report was [CVE-2011-2931](https://groups.google.com/d/topic/rubyonrails-security/K5EwdJt06hI/discussion)).

Brakeman will warn on affected versions if uses of `strip_tags` are detected.

## XSS in select Helper

This vulnerability was [reported a while ago](https://groups.google.com/d/topic/rubyonrails-security/CdoMUVpsRmQ/discussion), but it was unclear if it applied to Rails 2.x or just Rails 3. Thanks to Neil Matatall, it has been confirmed to be an issue in Rails 2.x as well.

Therefore, Brakeman will be reporting the vulnerability (`select` does not escape options list if supplied as a straight string) for Rails 2.x as well.

## Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

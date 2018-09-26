---
layout: post
title: "Brakeman 1.9.1 Released"
date: 2013-01-18 17:36
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

This released was forced due to messed up dependencies with Brakeman 1.9.0 and Ruby2Ruby - my fault entirely! As such, this release does not match the roadmap for 1.9.1, which will be changed to 1.9.2.

_Changes since 1.9.0_:

 * Add check for CVE-2012-5664 - SQL Injection
 * Add check for CVE-2013-0155 - SQL Injection
 * Add check for CVE-2013-0156 - Remote Code Execution
 * Add check for unsafe `YAML.load`
 * Update to RubyParser 3.1.1 (neersighted)
 * Remove ActiveSupport dependency (Neil Matatall)
 * Do not warn on arrays passed to `link_to` (Neil Matatall) ([#232](https://github.com/presidentbeef/brakeman/issues/232))
 * Warn on secret tokens ([#200](https://github.com/presidentbeef/brakeman/issues/200))
 * Warn on more mass assignment methods ([#223](https://github.com/presidentbeef/brakeman/issues/223))

### CVE-2012-5664 - SQL Injection

[CVE-2012-5664](https://groups.google.com/d/topic/rubyonrails-security/DCNTNp_qjFM/discussion) is a vulnerability Rails' dynamic finders. While dynamic finders (such as `User.find_by_name`) appear to take a single argument, they also accept a hash options which can be used to modify the SQL query. Normally the hash of options would be the second argument, but it can also be the first. If an application passes in user code as the first argument, it will be interpreted as the options hash, leading to SQL injection.

The provided fix is to only accept the hash if the dynamic finder is called with the proper number of arguments. A workaround is to always cast input to dynamic finders.

([changes](https://github.com/presidentbeef/brakeman/pull/228))

### CVE-2013-0155 - SQL Injection

[CVE-2013-0155](https://groups.google.com/d/topic/rubyonrails-security/c7jT-EeN9eI/discussion) is a SQL vulnerability where certain JSON input can cause `find` methods to add `NULL` as a valid value.

([changes](https://github.com/presidentbeef/brakeman/pull/239))

### CVE-2013-0156 - Remote Code Execution

[CVE-2013-0156](https://groups.google.com/d/topic/rubyonrails-security/61bkgvnSGTQ/discussion) is the worst Rails vulnerability in recent memory. It allows attackers to easily execute arbitrary code on any Rails application.

Besides upgrading Rails, there are workarounds for this issue: disable XML request parsing or disable YAML/symbol types inside XML requests.

Exploits for this vulnerability are easily available and already in use in the wild. Please upgrade, patch, or use a workaround.

([changes](https://github.com/presidentbeef/brakeman/pull/239))

### Check for `YAML.load`

In light of [CVE-2013-0156](https://groups.google.com/d/topic/rubyonrails-security/61bkgvnSGTQ/discussion), Brakeman will now warn on any uses of `YAML.load` with user input. Do not load arbitrary YAML in applications!

### Dependency Changes 

Brakeman now uses the latest RubyParser and Ruby2Ruby versions.

Thanks to Neil, Brakeman no longer depends on any version of ActiveSupport or i18n.

### Namespaced URLs in `link_to`

Brakeman will no longer warn on array arguments to `link_to`.

([changes](https://github.com/presidentbeef/brakeman/pull/233))

### Secret Tokens

Secret tokens stored in source control are bad! Doubly bad if the source code is available publicly. Anyone with access to an application's secret token can generate any session cookies they would like. See [this post](http://phenoelit.org/blog/archives/2012/12/21/let_me_github_that_for_you/index.html) for details.

([changes](https://github.com/presidentbeef/brakeman/pull/227))

### More Mass Assignment

Bryan Helmkamp pointed out more Rails methods which perform mass assignment. The following methods have been added: `first_or_create`, `first_or_create!`, `first_or_initialize!`, `assign_attributes`, and `update`.

([changes](https://github.com/presidentbeef/brakeman/pull/234))

### Report Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

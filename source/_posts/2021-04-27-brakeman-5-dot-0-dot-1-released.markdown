---
layout: post
title: "Brakeman 5.0.1 Released"
date: 2021-04-27 12:00
comments: true
categories:
permalink: /blog/:year/:month/:day/:title
---

Has it really been three months since Brakeman 5.0? Yikes!

Here's a small update with some bugfixes before we move on to 5.1.

_Changes since 5.0.0:_

* Support loading `slim/smart` ([#1570](https://github.com/presidentbeef/brakeman/issues/1570))
* Set more line numbers on Sexps ([#1579](https://github.com/presidentbeef/brakeman/issues/1579))
* Detect `::Rails.application.configure` too ([#1584](https://github.com/presidentbeef/brakeman/issues/1584))
* Always ignore `slice`/`only` calls for mass assignment
* Don't fail if $HOME/$USER are not defined
* Convert splat array arguments to arguments
* Bundle unreleased RubyParser changes

### Support Smart Text in Slim Templates

In order to support "[Smart Text](https://github.com/slim-template/slim/blob/master/doc/smart.md)" in Slim templates,
Brakeman will load `slim/smart` if `slim/smart` is mentioned in the `Gemfile`. 

([changes](https://github.com/presidentbeef/brakeman/pull/1582))

### More Line Numbers

Setting `nil` value for the line number of a Sexp raises an exception.

This is usually from creating a Sexp without a line number in the first place.

More instances of this have been fixed in this release.

([changes](https://github.com/presidentbeef/brakeman/pull/1581))

### Always Ignore slice/only for Mass Assignment

If `slice` or `only` are called for arguments to mass assignment (e.g. `User.new(some_hash.slice(:name, :email))`),
Brakeman will not warn about mass assignment.

These have been ignored for a while, but a logic error caused Brakeman to sometimes still warn about them.

([changes](https://github.com/presidentbeef/brakeman/pull/1565))

### Convert Splats to Arguments

In really obvious cases like

```ruby
some_call(*[a, b, c])
```

Brakeman will convert the arguments to

```ruby
some_call(a, b, c)
```

([changes](https://github.com/presidentbeef/brakeman/pull/1564))


### Checksums

The SHA256 sums for this release are:


### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release!

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release. Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.


---
layout: blog
title: Brakeman 4.8.2 Released
date: 2020-05-12 16:00
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.8.1
  changes:
  - Add `--text-fields` option
  - Add check for [CVE-2020-8159](https://groups.google.com/d/msg/rubyonrails-security/CFRVkEytdP8/c5gmICECAgAJ)
  - Add check for escaping HTML entities in JSON configuration option
  - Fix `authenticate_or_request_with_http_basic` check for passed blocks ([Hugo Corbucci](https://github.com/hugocorbucci))
checksums:
- hash: d7bf369896b4a3c41778f39f10b1e1d0844a965bbb582fa0a0566b1df4f07dec
  file: brakeman-4.8.2.gem
- hash: c13e9a9e5b213ba95a16803ddb50eb3c7119533ca71444ffec2bb6cea22b926a
  file: brakeman-lib-4.8.2.gem
- hash: a422a444b7db48682e1f112c83b1a7a7e3828ec02d52ed91c5b3eff235b801c1
  file: brakeman-min-4.8.2.gem
---


This release introduces a new option and two new checks!


## Text Fields Option

It is now possible to specify which text fields are reported and their order for the default "text" report format using the `--text-fields` option. 

Possible options are:

* `all`
* `category`
* `category_id`
* `check`
* `code`
* `confidence`
* `file`
* `fingerprint`
* `line`
* `link`
* `message`
* `render_path`

`--text-fields` accepts a comma-separated list of these options.

_Please keep in mind the JSON report should be used for structured reports/parsing._

([changes](https://github.com/presidentbeef/brakeman/pull/1473))

## CVE-2020-8159

This release includes a check for [CVE-2020-8159](ihttps://groups.google.com/d/msg/rubyonrails-security/CFRVkEytdP8/c5gmICECAgAJ) related to the `actionpack-page_caching` gem.
The vulnerability allows arbitrary file writing and may be escalated to remote code execution.

If `caches_page` is called in any controllers, this will be a High confidence warning. Otherwise, Weak.

_Reminder: Brakeman is not a 'dependency' scanner. It only includes checks for a small number of Rails-related CVEs. Use bundler-audit or related tools for dependency checking._

([changes](https://github.com/presidentbeef/brakeman/pull/1477/))

## JSON Escaping Configuration

Brakeman will now warn if HTML entity escaping in JSON is disabled globally with `ActiveSupport.escape_html_entities_in_json = false`. This is an unusual configuration. 

([changes](https://github.com/presidentbeef/brakeman/pull/1472))

## Basic Auth Check Fix

[Hugo Corbucci](https://github.com/hugocorbucci) fixed an error when checking calls to `authenticate_or_request_with_http_basic` without a block literal.

([changes](https://github.com/presidentbeef/brakeman/pull/1478))


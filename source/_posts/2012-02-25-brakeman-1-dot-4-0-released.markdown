---
layout: post
title: "Brakeman 1.4.0 Released"
date: 2012-02-25 09:57
comments: true
categories: 
---

This is not a big release, but it does add a new check. Also, processing for ERB templates with the `rails_xss` plugin has changed, so there is the possibility that line numbers for reported warnings will shift.

_Changes since 1.3.0:_

 * Add check for user input in link_to href parameter
 * Match ERB processing to rails_xss plugin when plugin used
 * Add Brakeman::Report#to_json, Brakeman::Warning#to_json
 * Warnings below minimum confidence are dropped completely
 * Brakeman.run will now always return a Tracker


### New Check for link_to

[Neil Matatall](https://github.com/oreoshake) has contributed a new check for the href parameter in `link_to`. Even if HTML escaped, some values can be dangerous, so this check will warn for user input in that parameter. See [here](https://github.com/presidentbeef/brakeman/pull/45) for more details.

The `--url-safe-methods` option can be used to specify escaping methods which are safe for urls.

### ERB and rails_xss

The `rails_xss` plugin has some fixes for how Erbuis handles certain input. Brakeman now matches those changes, which fixes some parsing errors.

### Internal Changes

There have been some changes which only impact those working with Brakeman as a library.

First, there is now json output for reports. This actually should be an output format option, but I did not realize it until writing this post. The next release will include this, though!

The way Brakeman handles the `--confidence-level` option has also changed. In the past, warnings would be filtered when output in a report. This meant, for example, that `tracker.checks.all_warnings` would still return warnings below the specified confidence level. It also caused problems because there were many places in the code where the warnings needed to be filtered. With this release, warnings below the confidence level will be dropped as soon as they are found and will not need to be filtered at any later point.

Lastly, `Brakeman.run` would return `false` if `--exit-on-warn` was set, and a `Tracker` object otherwise. This has changed. `Brakeman.run` will now always return a `Tracker` object and the logic for `--exit-on-warn` was pushed out to the Brakeman executable. 

### Report Issues

As usual, please [report any issues](https://github.com/presidentbeef/brakeman/issues).

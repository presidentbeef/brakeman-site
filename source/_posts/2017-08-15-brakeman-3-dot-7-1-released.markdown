---
layout: post
title: "Brakeman 3.7.1 Released"
date: 2017-08-15 23:38
comments: true
categories: 
---

Just a little release. Next up: 4.0!

*Changes since 3.7.0:*

* Handle simple guard with `return` at end of branch ([#1073](https://github.com/presidentbeef/brakeman/issues/1073))
* Add more collection methods for iteration detection
* Modularize `bin/brakeman`
* Improve multi-value `Sexp` error message
* Update `ruby2ruby` and `ruby_parser` dependencies

### Another Simple Guard

Brakeman will now handle when the branch in a simple guard condition ends in `return`.

For example:

    unless [:valid, :value].include? params[:x]
      do_stuff
      more_stuff
      return
    end

    x.send(params[:x]) # Will no longer warn because `params[:x]` must be 'safe'

([changes](https://github.com/presidentbeef/brakeman/pull/1077))

### More Collection Methods

Brakeman attempts to detect when a template is iterating over records from a database query.

This release adds a few more methods that might return a collection of records. 

([changes](https://github.com/presidentbeef/brakeman/pull/1074))

### Modularize Commandline

The logic in the `brakeman` executable has now entirely been moved to [`Brakeman::Commandline`](https://github.com/presidentbeef/brakeman/blob/49f675a88ba12ad4fa799770f5499c952650a56c/lib/brakeman/commandline.rb) for easier testing and custom behavior.

([changes](https://github.com/presidentbeef/brakeman/pull/1076))

### Checksums

The SHA256 sums for this release are:

    8f1405d75f7b5ff55884288084177e3379ab3c92460fc4d3641b036063aafd61  brakeman-3.7.1.gem
    a9fa8ea0c70fdd35929deab96dbc5facf72093b4bddbae45edcae3636ffea31e  brakeman-min-3.7.1.gem
    64650208fc770e5010f5d3b58bd608e7cefd1155dc5916918033e554bac0a8e2  brakeman-lib-3.7.1.gem


### Brakeman 4.0 Plans

If all goes well, Brakeman 4.0 will be released on August 27th, which is also the 7th anniversary of Brakeman's first release. It will also be the 100th release of Brakeman!

At least two major changes will be coming in Brakeman 4.0:

* The `plain` report format will be the default instead of tables
* `-z` or `--exit-on-warn` (sets exit code if any warnings are found) will be on by default

There will likely be other changes, but these two will be the most obvious.

### Reporting Issues

Thank you to everyone who reported bugs and contributed to this release.

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Follow [@brakeman](https://twitter.com/brakeman) on Twitter and hang out [on Gitter](https://gitter.im/presidentbeef/brakeman) for questions and discussion.

If you find Brakeman valuable and want to support its development, check out [Brakeman Pro](https://brakemanpro.com/).

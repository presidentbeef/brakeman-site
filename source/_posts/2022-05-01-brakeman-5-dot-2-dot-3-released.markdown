---
layout: blog
title: Brakeman 5.2.3 Released
date: 2022-05-01 08:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 5.2.2
  changes:
  - Fix error with hash shorthand syntax ([#1700](https://github.com/presidentbeef/brakeman/issues/1700))
  - Match order of interactive options with help message ([Rory O'kane](https://github.com/roryokane))
checksums:
- hash: 5b6efb6a1e5c2b79063553647638e17239d2d2f4d50561230c8b0acaae4728d4
  file: brakeman-5.2.3.gem
- hash: 3104abc8ac2b6558d9610ede40f4cac2ebc7ae45569876b8e5907b7422c4e3af
  file: brakeman-lib-5.2.3.gem
- hash: 10d743c930c03ed1d2bea021ade8fac10f1229d02b8f65bf2214f7f09ec7a0ff
  file: brakeman-min-5.2.3.gem
---



## Hash Shorthand Syntax 

Parsing shorthand hash syntax like this was added with RubyParser 3.19:

```ruby
thing = 1

blah(thing:)
```

but Brakeman needed to handle it properly, too. 

([changes](https://github.com/presidentbeef/brakeman/pull/1701))

## Interative Options 

[Rory O'kane](https://github.com/roryokane) updated the ordering of options in the help message for interative ignore so
the help message matches the order of the options in the prompt!

([changes](https://github.com/presidentbeef/brakeman/pull/1702))


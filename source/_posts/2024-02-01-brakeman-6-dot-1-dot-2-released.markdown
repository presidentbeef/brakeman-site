---
layout: blog
title: Brakeman 6.1.2 Released
date: 2024-02-01 10:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 6.1.1
  changes:
  - Avoid detecting Phlex components as dynamic render paths ([Máximo Mussini](https://github.com/ElMassimo))
  - Avoid detecting `ViewComponentContrib::Base` as dynamic render paths ([vividmuimui](https://github.com/vividmuimui))
  - Avoid copying Sexps that are too large ([#1818](https://github.com/presidentbeef/brakeman/issues/1818),
    [#1546](https://github.com/presidentbeef/brakeman/issues/1546))
  - Add EOL date for Ruby 3.3.0
  - Remove deprecated use of `Kernel#open("|...")`
  - Remove `safe_yaml` gem dependency
  - Update Highline to 3.0 ([#1812](https://github.com/presidentbeef/brakeman/issues/1812))
checksums:
- hash: 7716769c18f2c4a52d7a74d2cb5a614be0c46d8aad3fbe7ca089dbb7c98bd4d3
  file: brakeman-6.1.2.gem
- hash: 38939998eb695b82932c207ef766356bc21e57199e18c4d8f000a005d294e587
  file: brakeman-lib-6.1.2.gem
- hash: dbc2f9a3b61760c03737cf701f5a1dfe634fb14e8388968e056a0f77effab018
  file: brakeman-min-6.1.2.gem
---


Finally, just a small release!


## Components in Render Paths

Thanks to [Máximo Mussini](https://github.com/ElMassimo) and [vividmuimui](https://github.com/vividmuimui), there will be fewer false positives
warning about dynamic render paths when using components.

([changes](https://github.com/presidentbeef/brakeman/pull/1805))

([changes](https://github.com/presidentbeef/brakeman/pull/1821))

## Performance Improvement with Complex Branching

Brakeman has a very hard time with code like

```ruby
x = thing
x = foo(x)

if x
    x = bar(x)
else
    x = baz(x)
end

x = do_thing(x)

# etc.
```

Because to Brakeman it looks like

```ruby
x = thing
x = foo(thing)

if foo(thing)
    x = bar(foo(thing))
else
    x = baz(foo(thing))
end

x = do_thing(bar(foo(thing)) || baz(foo(thing)))
```

This can quickly snowball into gigantic chunks of code, causing Brakeman to use lots of memory and essentially freeze up.

In the past, limits on how many times a value is "branched" have helped with this (and is configurable with `--branch-limit`).
However, it is not sufficient.

Now Brakeman has a limit on how large these chunks of code can get. This has improved performance without any noticable impact on true positives.

([changes](https://github.com/presidentbeef/brakeman/pull/1820))


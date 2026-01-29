---
layout: blog
title: "Brakeman 8.0.0"
subtitle: "New commandline output and breaking changes"
date: 2026-01-29
version: "8.0.0"
changelog:
  since: "7.1.2"
  changes:
    - "Complete revamp of scan progress output and logging"
    - "`--skip-libs` removed ([#1839](https://github.com/presidentbeef/brakeman/issues/1839)"
    - "`--index-libs` removed"
    - "Fix qualified constant lookup to respect module/class context ([Mike Dalessio](https://github.com/flavorjones))"
    - "Fix singleton method prefixes ([viralpraxis](https://github.com/viralpraxis))"
    - "Faster file globbing for templates ([Mikael Henriksson](https://github.com/mhenrixon))"
    - "No longer produce weak dynamic render path warnings"
    - "Replace Erubis with Erubi ([#1970](https://github.com/presidentbeef/brakeman/issues/1970))"
checksums:
  - hash: "9fd6e793d1f8e581dd864a0e0dee3ce8864e2902fcbd314d21f952f9751dd2f6"
    file: "brakeman-8.0.0.gem"
  - hash: "aa57330b2428d2d608550da9cab80d7a3bbef10e69ed0e1640608a6963f2180a"
    file: "brakeman-lib-8.0.0.gem"
  - hash: "30d614172dc987339b49b2eb39434326212cb49e300e011ef5c8ff17ff795942"
    file: "brakeman-min-8.0.0.gem"
permalink: /blog/:year/:month/:day/:title
---

## New Scanner Progress Output 

How Brakeman outputs scan progress has been completely updated!

<video src="/video/brakeman-ui-2026.webm" alt="Refreshed Brakeman scanner progress output" type="video/webm" loop=true autoplay=true></video>

Hopefully this feels more modern and less cluttered.

Don't like the colors? `--no-color` will switch Brakeman to black-and-white (or whatever your terminal shows) output.

Don't like the animation? `--no-progress` will switch Brakeman to a simplified output.

(Note that `--no-progress` has always been recommended if the output is going somewhere that acts like a terminal but
really isn't, like CI logs.)

Other logging has also been improved. `--timing` is now similar to `--no-progress`, but of course with information about elapsed time.

`--debug` continues to dump tons of information, but with some improved colors.

**There may be bugs lurking, as this was a large code/behavior change.** Please report any issues!

([changes](https://github.com/presidentbeef/brakeman/pull/1993))

## Removed Options

`--skip-libs` and `--index-libs` have been removed as options.

As noted in [](), `--skip-libs` has been completely broken for a while. The original intent was to make it easy to skip the `lib/` directory, back when it wasn't as valuable to Brakeman. Now, however, Brakeman ingests (almost) all Ruby files and sorts them out based on content rather than paths.

To have Brakeman skip specific directories, use `--skip-files` instead.

`--index-libs` was introduced mainly for `--no-index-libs`, which I'm sure no one ever used.

([changes](https://github.com/presidentbeef/brakeman/pull/1997))

## Improved Constant Lookups

Thanks to [Mike Dalessio](https://github.com/flavorjones), Brakeman now stores and uses more context for constants. This makes it more likely that it will find the right constant when trying to resolve constant values.

This is huge! Previously, Brakeman would mix up constants with the same name in different contexts and ignore any scoping.

([changes](https://github.com/presidentbeef/brakeman/pull/1981))

## Singleton Method Prefixes

Ever seen Brakeman output like `s(:self).my_cool_method`? This has been a known problem with methods defined as `def self.my_cool_method` (or more unusually `def MyClass.my_cool_method`) for a long time. But [viralpraxis](https://github.com/viralpraxis) fixed it up!

Unfortunately, this will very likely impact ignored fingerprints if such a method is involved in a warning. But it's worth it for cleanup (also hey it's a major version upgrade!)

([changes](https://github.com/presidentbeef/brakeman/pull/1976))

## Faster File Collection for Templates

[Mikael Henriksson](https://github.com/flavorjones) noticed the faster file search in [Brakeman 7.1.1](http://localhost:4000/blog/2025/11/03/brakeman-7-dot-1-dot-1-released) didn't apply to template files.

He fixed that up so Brakeman should be nice and speedy on MacOS.

([changes](https://github.com/presidentbeef/brakeman/pull/1991))

## No More Weak Dynamic Render Path Warnings

Dynamic render paths (allowing user input to influence which template file is rendered) have been the source of many false positives and
it has become quite a bit harder to exploit them due to how and where Rails searches for matching templates.

Most false positives were from low confidence warnings about method calls that might have included user input somewhere in their arguments.

This release drops any dynamic render path warnings that were low confidence. It's still best not to allow direct manipulation of which templates are rendered.

([changes](https://github.com/presidentbeef/brakeman/pull/1997))

## Erubis Replaced with Erubi

Rails swapped Erubis for Erubi back in the 5.1 release. Functionally, from Brakeman's point of view, it does not make a big difference and was not worth the effort to change.

However, Erubi hasn't been touched since 2011. Time to catch up with the modern world.

The main side-effect of swapping to Erubi appears to be more accurate line numbers, which is great! Everything else should be the same.

([changes](https://github.com/presidentbeef/brakeman/pull/1990))

---
layout: blog
title: Brakeman 4.9.0 Released
date: 2020-08-04 11:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.8.2
  changes:
  - Add `--ensure-ignore-notes` ([Eli Block](https://github.com/eliblock))
  - Add check for user input in `ERB.new` ([Matt Hickman](https://github.com/mhickman))
  - Add check for CVE-2020-8166 ([Jamie Finnigan](https://github.com/chair6))
  - Always scan `environment.rb`
  - 'Avoid warning when `safe_yaml` is used via `YAML.load(..., safe: true)`'
  - Do not warn about mass assignment with `params.permit!.slice`
  - Ignore `params.permit!` in path helpers
  - Treat `Dir.glob` as safe source of values in guards
  - Remove whitelist/blacklist language, add clarifications
  - Add "full call" information to call index results
  - Updated Slim dependency ([Jeremiah Church](https://github.com/JeremiahChurch))
checksums:
- hash: 3afcfee962907361cbc5047b7089eaa7c31546cc4de201939faba6d3a1b07a18
  file: brakeman-4.9.0.gem
- hash: dc6a50321170e83e61ae75d1bb2dade53392a44b614d4068553f1425539a3b8f
  file: brakeman-lib-4.9.0.gem
- hash: 4c8ea640925bf33a775729b000b91312abe42ea7945dac1a6bfcc0347fb6323d
  file: brakeman-min-4.9.0.gem
---


It's been a while! This will (probably) be the last minor release before **5.0**.


## Ensuring Notes Are Added For Ignored Warnings

[Eli Block](https://github.com/eliblock) has added a new option to ensure all ignored warnings have notes.

If `--ensure-ignore-notes` is set and the configured "ignore" file does not have notes for all warnings, a non-zero exit code will be set.

([changes]())

## Check for Template Injection

[Matt Hickman](https://github.com/mhickman) added a new check for user input in calls to `ERB.new` which can lead to remote code execution.

([changes](https://github.com/presidentbeef/brakeman/pull/1395))

## Check for CVE-2020-8166

[Jamie Finnigan](https://github.com/chair6) added a new check for [CVE-2020-8166](https://groups.google.com/g/rubyonrails-security/c/NOjKiGeXUgw).

_(Note, in general you should not rely on Brakeman for vulnerable dependency checks. There are much better tools available now!)_

([changes](https://github.com/presidentbeef/brakeman/pull/1493))

## Always Scan Environment

Brakeman used to conditionally scan `config/environment.rb` based on the Rails version, since in newer versions there's nothing of interest in that file.

However, some applications do use that file for important constant definitions. Since there is no harm in doing so, Brakeman will now always scan `config/environment.rb`.

([changes](https://github.com/presidentbeef/brakeman/pull/1480))

## More Safe YAML

Brakeman will no longer warn about deserialization if the [`safe_yaml`](https://rubygems.org/gems/safe_yaml) gem is used with `YAML.load(..., safe: true)`.

([changes](https://github.com/presidentbeef/brakeman/pull/1496))

## Mass Assignment False Positives

Brakeman will no longer warn about mass assignment with `params.permit!.slice` or when `params.permit!` is used as an argument to a path helper (e.g. `something_path(params.permit!)`).

([changes](https://github.com/presidentbeef/brakeman/pull/1485) and [changes](https://github.com/presidentbeef/brakeman/pull/1484))

## Dir.glob in Guards 

Brakeman will now consider `Dir.glob` to be a safe source of values in guard statements.

In other words, code like this:

```ruby
  def show
    template = params[:template]
    files = Dir.glob("/some/template/path/*")

    # Guard condition using Dir.glob results
    return redirect_to '/groups' unless files.include? template

    # Will not warn because we are checking `files` for `params[:template]` above
    render "groups/#{template}"
  end
```

([changes](https://github.com/presidentbeef/brakeman/pull/1481))

## Updated Warning Messages 

Updated a few warning messages to be clearer instead of just using 'whitelist'/'blacklist' as a verb.

([changes](https://github.com/presidentbeef/brakeman/pull/1486))


---
layout: blog
title: "Brakeman 8.0.3"
subtitle: "Bug fixes and age delay for --ensure-latest"
date: 2026-02-26
version: "8.0.3"
changelog:
  since: "8.0.2"
  changes:
    - "Add release age option for `--ensure-latest` ([#1989](https://github.com/presidentbeef/brakeman/issues/1989))"
    - "Fix `polymorphic_name` SQLi false positive ([Fredrico Franco](https://github.com/FFederi))"
    - "Fix logger behavior when loading config files ([#2009](https://github.com/presidentbeef/brakeman/issues/2009))"
    - "Handle application names with module prefixes ([#2011](https://github.com/presidentbeef/brakeman/issues/2011))"
checksums:
  - hash: "19713795e0496937bb7a817967461963e9533f180b0e608adbee3c4780be61c6"
    file: "brakeman-8.0.3.gem"
  - hash: "89074c3f9141adb7b6eedcdf2542269a08044252fda426db1ba606e4a157a11e"
    file: "brakeman-lib-8.0.3.gem"
  - hash: "973ffa1883ee688a46e6a9681be3e96a682872dcd6eb782cd062f5d7dbfacf0b"
    file: "brakeman-min-8.0.3.gem"
permalink: /blog/:year/:month/:day/:title
---

## Add Age Option for Latest Release

When using `--ensure-latest`, you can now specify a minimum age (in days) for the latest release. The intent is to protect against supply chain attacks in case
the Brakeman gems are compromised.

`--ensure-latest 10` will only return a non-zero exit code if the latest version of Brakeman is at least 10 days old.
Note that for performance reasons, Brakeman will only check the _latest_ version, it will not try to find an less-recent version that meets the age requirements.
This means you may miss versions if the releases are too close together.

([changes](https://github.com/presidentbeef/brakeman/pull/2008))

## Ignore `polymorphic_name` in SQL

[Fredrico Franco](https://github.com/FFederi) fixed a false positive where Brakeman would erroneously warn about [polymorphic_name](https://api.rubyonrails.org/classes/ActiveRecord/Inheritance/ClassMethods.html#method-i-polymorphic_name)
in SQL queries.

([changes](https://github.com/presidentbeef/brakeman/pull/2014))

## Fix Another Disappearing Cursor Issue

Fixed an issue where setting `--quiet` and loading a configuration file would cause the terminal cursor to not be restored when Brakeman exits.

([changes](https://github.com/presidentbeef/brakeman/pull/2013))

## Application Names with Module Prefixes

Brakeman will now correctly pick up configurations where the application is defined as

```ruby
class MyApp::Application < Rails::Application
  # ...
end
```

instead of

```ruby
module MyApp
  class Application < Rails::Application
    # ...
  end
end
```

([changes](https://github.com/presidentbeef/brakeman/pull/2012))

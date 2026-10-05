---
layout: blog
title: "Brakeman 8.1.0"
subtitle: "Updated SonarQube format, updated validation regex warnings, more!"
date: 2026-09-30
version: "8.1.0"
changelog:
  since: "8.0.6"
  changes:
    - "Update SonarQube report to use generic issue format ([fangxing](https://github.com/fffx))"
    - "Include regex code in validation warnings ([Eliot Sykes](https://github.com/eliotsykes))"
    - "Check validation regexes in non-activerecord models ([Eliot Sykes](https://github.com/eliotsykes))"
    - "Skip top-level vendor directory before recursive globbing ([Conor O'Donnell](https://github.com/ronocod))"
    - "Support Rails 7.1+ positional enum syntax in SQL injection check ([Michael Vogl](https://github.com/cubasepp)/[Yuriy Tumanov](https://github.com/Eljees))"
    - "Recognize `Haml::AttributeBuilder.build_class` as an escaped output ([Yuriy Tumanov](https://github.com/Eljees))"
    - "Fix frozen string error ([Shai Coleman](https://github.com/shaicoleman))"
    - "Better help and error message for `--ensure-latest` ([#2036](https://github.com/presidentbeef/brakeman/issues/2036))"
checksums:
  - hash: "cfa9e5214e4925842f4bc849a64f8a7e6c5d0425fe98eac8d7b7bc60fdc17e07"
    file: "brakeman-8.1.0.gem"
  - hash: "88c56fa1bf295164f3f6a73bb627830d8d641a9b08e0b8683113acb694273ca4"
    file: "brakeman-lib-8.1.0.gem"
  - hash: "320e25c6e8e1638376a25bdbeffa358457cb19a1385db4497ed10d2a4028d33e"
    file: "brakeman-min-8.1.0.gem"
permalink: /blog/:year/:month/:day/:title
---

### SonarQube Report Format

When using the Sonar format report (`-f sonar`), Brakeman will now use the newer [generic issues report](https://docs.sonarsource.com/sonarqube-server/analyzing-source-code/importing-external-issues/generic-issue-import-format).

In theory, you could also use the SARIF report (`-f sarif`) but this has not been tested.

Thanks Fangxing!

([changes](https://github.com/presidentbeef/brakeman/pull/2038))

### Validation Regex Changes

Previously, Brakeman was not including the validation regex itself when warning about insufficient anchoring.
This could cause two different validation warnings to have the same fingerprint.

```ruby
validates_format_of :something, /^something$/
```

This has been rectified, thanks to Eliot Sykes. However, this will mean fingerprint values will change for existing validation regex warnings.

Eliot also expanded Brakeman's check for insufficient anchoring in validation regexes to include non-ActiveRecord models.

([changes](https://github.com/presidentbeef/brakeman/pull/2050))

([changes](https://github.com/presidentbeef/brakeman/pull/2053))

### Better Vendor Directory Skipping

Brakeman skips the top-level vendor directory by default or if `--skip-vendor` is used.

However, there were performance issues because while files in the directory were skipped, they were still searched for matching file names.

Conor noticed the performance problem and fixed it!

([changes]())

### Newer Enum Support

Michael Vogl added support for the newer (Rails 7.1+) syntax for enums:

```ruby
enum :status, active: 0, archived: 1
```

And Yuriy Tumanov fixed up the tests for it.

([changes](https://github.com/presidentbeef/brakeman/pull/1946))

### More Haml Builders

Yuriy also fixed an issue where `Haml::AttributeBuilder.build_class` was falsely being reported as vulnerable to cross-site scripting.

([changes](https://github.com/presidentbeef/brakeman/pull/2052))




- Update SonarQube report to use generic issue format ([fangxing](https://github.com/fffx))
- Include regex code in validation warnings ([Eliot Sykes](https://github.com/eliotsykes))
- Check validation regexes in non-activerecord models ([Eliot Sykes](https://github.com/eliotsykes))
- Skip top-level vendor directory before recursive globbing ([Conor O'Donnell](https://github.com/ronocod))
- Support Rails 7.1+ positional enum syntax in SQL injection check ([Michael Vogl](https://github.com/cubasepp)/[Yuriy Tumanov](https://github.com/Eljees))
- Recognize `Haml::AttributeBuilder.build_class` as an escaped output ([Yuriy Tumanov](https://github.com/Eljees))
- Fix frozen string error ([Shai Coleman](https://github.com/shaicoleman))
- Better help and error message for `--ensure-latest` ([#2036](https://github.com/presidentbeef/brakeman/issues/2036)

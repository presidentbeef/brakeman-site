---
layout: blog
title: Brakeman 5.3.0 Released
date: 2022-08-09 08:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 5.2.3
  changes:
  - Add CWE information to warnings ([Stephen Aghaulor](https://github.com/saghaulor))
  - Include explicit engine or lib paths in `vendor/` ([Joe Rafaniello](https://github.com/jrafanie))
  - Add check for CVE-2022-32209
  - Load rexml as a Brakeman dependency
  - Fix "full call" information propagating unnecessarily
checksums:
- hash: 4fe584ef37c16e1011a0f2db36ebab540fef403ff8e26afed212e2d7ff5a3176
  file: brakeman-5.3.0.gem
- hash: 1f5caa0bd05fd8ea5b4f5791371dd0911f96d804612c7be986bab3ed0163a8cf
  file: brakeman-lib-5.3.0.gem
- hash: 4a4ccef090c4eb5857140c15fa69ff65167f3eb550f7a0ca555012642aafe7e9
  file: brakeman-min-5.3.0.gem
---


This release adds CWE information to reports - the first JSON report change in a long time!


## CWE Information 

Thanks to [Stephen Aghaulor](https://github.com/saghaulor) for taking on the arduous task of adding CWE information
to every Brakeman warning type!

CWE information is now available in most report formats. In particular, it is a new field for the JSON report.

Example:

```json
    {
      "warning_type": "Cross-Site Scripting",
      "warning_code": 124,
      "fingerprint": "c2cc471a99036432e03d83e893fe748c2b1d5c40a39e776475faf088717af97d",
      "check_name": "SanitizeConfigCve",
      "message": "rails-html-sanitizer 1.4.2 is vulnerable to cross-site scripting when `select` and `style` tags are allowed (CVE-2022-32209)",
      "file": "config/initializers/sanitizers.rb",
      "line": 1,
      "link": "https://groups.google.com/g/rubyonrails-security/c/ce9PhUANQ6s/m/S0fJfnkmBAAJ",
      "code": "Rails::Html::SafeListSanitizer.allowed_tags = [\"select\", \"a\", \"style\"]",
      "render_path": null,
      "location": null,
      "user_input": null,
      "confidence": "High",
      "cwe_id": [
        79
      ]
    }
```

([changes](https://github.com/presidentbeef/brakeman/pull/1693))

## Explicit Paths in Vendor Directory 

By default, Brakeman does not scan any code in the `vendor/` directory.

But it was also ignoring any paths in `vendor/`, even if the user explicitly included them via `--add-libs-path` or `--add-engines-path`.

Thanks to [Joe Rafaniello](https://github.com/jrafanie) this is now changed to respect the explicit additional paths, even if they reside in `vendor/`.

([changes](https://github.com/presidentbeef/brakeman/pull/1699))

## CVE-2022-32209

_As a reminder, Brakeman does not keep up with every CVE for Rails or other libraries. Use a dependency analysis tool for that!_

A check was added for [CVE-2022-32209](https://hackerone.com/reports/1530898).

If the vulnerable configuration is detected, the warning will be `high` confidence.

If only the vulnerable version of `rails-html-sanitizer` is detected, the warning will be `weak` confidence. 

([changes](https://github.com/presidentbeef/brakeman/pull/1718))


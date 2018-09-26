---
layout: page
title: "Attribute Restriction"
date: 2011-11-10 12:46
comments: false
sharing: true
footer: true
---

This warning type only applies to Ruby on Rails applications which are not using [strong parameters](https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters).

Note that disabling mass assignment globally will suppress these warnings.

#### Missing Protection

This warning comes up if a model does not limit what attributes can be set through [mass assignment](https://guides.rubyonrails.org/v3.2.9/security.html#mass-assignment).

In particular, this check looks for `attr_accessible` inside model definitions. If it is not found, this warning will be issued.

#### Use of Blacklist

Brakeman also warns on use of `attr_protected` - especially since it was found to be [vulnerable to bypass](https://groups.google.com/d/topic/rubyonrails-security/AFBKNY7VSH8/discussion). Warnings for mass assignment on models using `attr_protected` will be reported, but at a lower confidence level.

#### Suggested Remediation

For newer Ruby on Rails applications, query parameters should be whitelisted before use via strong parameters.

For older Ruby on Rails applications, each model should use `attr_accessible` to carefully whitelist which attributes may be set via mass assignment, if any.

---

Back to [Warning Types](/docs/warning_types)

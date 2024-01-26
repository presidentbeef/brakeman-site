---
layout: page
title: "Unmaintained Dependencies"
date: 2024-01-24 16:01
comments: false
sharing: true
footer: true
---

Unmaintained or "end-of-life" dependencies can present security risks to your application.

When a dependency is no longer maintained, its developers may not release new versions with security patches for known 
vulnerabilities. This means that any known vulnerabilities in the dependency remain unpatched, leaving your application open to attacks.

In addition to known vulnerabilities, older versions of software are likely to receive less scrutiny
are more likely to contain vulnerabilities that are not published and do not receive any public attention.

Maintained dependencies are also more likely to follow security best practices, such as using secure coding practices, 
regularly testing for vulnerabilities, and providing timely security patches. Outdated dependencies may not follow these best practices, increasing the 
risk of security vulnerabilities.

As a library ages, it is more likely to be completely abandoned or forgotten by its creator.
Abandoned libraries may become target for supply chain attacks, where the attacker takes over an old code repository or
an account on a package management server (such as RubyGems) and publishes a malicious version of the software.

## Ruby and Rails

Ruby versions are generally maintained for 3 years and 3 months after release. Check [the listing of maintenance branches](https://www.ruby-lang.org/en/downloads/branches/) for more information.

Rails is more complicated, but generally only the current series and the last of the previous series is supported. See the [Rails Maintenance Policy](https://guides.rubyonrails.org/maintenance_policy.html#security-issues).

---
Back to [Warning Types](/docs/warning_types)

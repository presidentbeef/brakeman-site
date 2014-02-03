---
layout: page
title: "Session Settings"
date: 2011-11-10 16:15
comments: false
sharing: true
footer: true
---

### HTTP Only

It is recommended that session cookies be set to "http-only". This helps prevent stealing of cookies via cross site scripting.

### Secret Length

Brakeman will warn if the key length for the session cookies is less than 30 characters.

### Version control inclusion

Brakeman will warn if the config/initializers/secret_token.rb is included in the version control. It is recommended that secret_token.rb is excluded from version control, and included in .gitignore

---
Back to [Warning Types](/docs/warning_types)


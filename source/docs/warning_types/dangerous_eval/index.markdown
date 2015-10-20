---
layout: page
title: "Dangerous Evaluation"
date: 2011-11-10 12:47
comments: false
sharing: true
footer: true
---

User input in an `eval` statement is VERY dangerous, so this will always raise a warning. Brakeman looks for calls to `eval`, `instance_eval`, `class_eval`, and `module_eval`.

---
Back to [Warning Types](/docs/warning_types)

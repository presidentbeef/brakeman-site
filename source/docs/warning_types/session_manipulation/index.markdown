---
layout: docs
title: "Session Manipulation"
date: 2015-12-28 07:43
comments: false
sharing: true
footer: true
---

Session manipulation can occur when an application allows user-input in session keys.
Since sessions are typically considered a source of truth (e.g. to check the logged-in user or to match CSRF tokens),
allowing an attacker to manipulate the session may lead to unintended behavior.

For example:

    user_id = session[params[:name]]
    current_user = User.find(user_id)

In this scenario, the attacker can point the `name` parameter to some other session value (for example, `_csrf_token`) that will be interpreted
as a user ID. If the ID matches an existing account, the attacker will now have access to that account.

To prevent this type of session manipulation, avoid using user-supplied input as session keys.

([See here for a tiny, self-contained challenge demonstrating this issue](https://gist.github.com/joernchen/9dfa57017b4732c04bcc).)

---

Back to [Warning Types](/docs/warning_types)

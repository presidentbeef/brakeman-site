---
layout: page
title: "Redirect"
date: 2011-11-09 15:21
comments: false
sharing: true
footer: true
---

Unvalidated redirects and forwards are #10 on the [OWASP Top Ten](https://www.owasp.org/index.php/Top_10_2010-A10).

Redirects which rely on user-supplied values can be used to "spoof" websites or hide malicious links in otherwise harmless-looking URLs. They can also allow access to restricted areas of a site if the destination is not validated.

Brakeman will raise warnings whenever `redirect_to` appears to be used with a user-supplied value that may allow them to change the `:host` option.

For example,

    redirect_to params.merge(:action => :home)

will create a warning like

    Possible unprotected redirect near line 46: redirect_to(params)

To protect these redirects, use `:only_path => true` to limit the redirect to the current host or specify the host.

---
Back to [Warning Types](/docs/warning_types)

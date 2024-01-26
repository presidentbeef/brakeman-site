---
layout: page
title: "Redirect"
date: 2011-11-09 15:21
comments: false
sharing: true
footer: true
---

Unvalidated redirects and forwards are #10 on the [OWASP Top Ten](https://web.archive.org/web/20190223031311/https://www.owasp.org/index.php/Top_10_2010-A10).

Redirects which rely on user-supplied values can be used to "spoof" websites or hide malicious links in otherwise harmless-looking URLs. They can also allow access to restricted areas of a site if the destination is not validated.


Brakeman will raise warnings whenever `redirect_to` appears to be used with a user-supplied value that may allow them to change the `:host` option.

For example,

    redirect_to params.merge(:action => :home)

will create a warning like

    Possible unprotected redirect near line 46: redirect_to(params)

This is because `params` could contain `:host => 'evilsite.com'` which would redirect away from your site and to a malicious site.

If the first argument to `redirect_to` is a hash, then adding `:only_path => true` will limit the redirect to the current host. Another option is to specify the host explicitly.

    redirect_to params.merge(:only_path => true)

    redirect_to params.merge(:host => 'myhost.com')

If the first argument is a string, then it is possible to parse the string and extract the path:

    redirect_to URI.parse(some_url).path

**If the URL does not contain a protocol (e.g., `http://`), then you will probably get unexpected results, as `redirect_to` will prepend the current host name and a protocol.**

### Rails 7 Updates

If `config.action_controller.raise_on_open_redirects` is `true` (default for _new_ Rails 7.0 applications), then Rails will not allow redirecting to a domain that differs from the request.

Even if the configuration setting is not `true`, the protection can be applied by setting `allow_other_host: false` explicitly:

    redirect_to params[:url], allow_other_host: false

The code above will raise an exception if `params[:url]` does not match the current domain.

Brakeman will warn about calls where `allow_other_host` is set to `true`.

To coerce the URL to be "safe", use [`url_from`](https://api.rubyonrails.org/v7.0/classes/ActionController/Redirecting.html#method-i-url_from):

    redirect_to url_from(params[:url])

If the URL is does not match the current domain, then `url_from` returns `false`. The recommended pattern is to provide a fallback:

    redirect_to url_from(params[:url]) || some_safe_default_url

---
Back to [Warning Types](/docs/warning_types)

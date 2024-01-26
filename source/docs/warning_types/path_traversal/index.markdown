---
layout: page
title: "Path Traversal"
date: 2024-01-24 16:01
comments: false
sharing: true
footer: true
---

Path traversal vulnerabilities allow an attacker to access or manipulate files outside the intended
directory by providing specially crafted paths as input to read or write sensitive data. This can occur when 
improperly handling user-supplied input in filesystem-related operations such as image uploads, dynamic content loading, and user file downloads.

An attacker could exploit a path traversal vulnerability to:

* Read sensitive files, including configuration files or other data containing credentials or encryption keys.
* Write files into restricted directories that enables code injection or privilege escalation.
* Download or delete critical system files.
* Gain access to user data and perform unauthorized actions.

## Example

```ruby
# `params[:file][:path]` could contain "../../../../../etc/passwd", e.g.

send_file File.join('some', 'path', params[:file][:path])
```

## Pathname Confusion

`Pathname#join` has some confusing behavior: _any_ absolute path segment (e.g. starting with `/`) causes the path to be absolute from that point.

Example:

```
> Pathname.new('a').join("a", "b", "/c", "d")
 => #<Pathname:/c/d> 
```

Note that `Rails.root` is a `Pathname`.

Exercise extreme caution when passing user-provided input to this function.

### Additional Protections

Besides coding defensively, there are additional options for protecting against path traversal:

* Use the ActiveStorage module for handling uploaded files and store them in a service like S3, rather than storing user data on the same server or directory as the application.
* Configure permissions on the application server to disallow writing files or reading files outside of the application directory.
* Never include user-provided values in the file path or the file name.

A common pattern is to store files using application-generated file names, but keep a record of the user-provided name. When the user downloads the file, the [`download`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-download) attribute and/or the [Content Disposition](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Disposition) header can be used to tell the browser the preferred name of the file, which can be the original user-provided name. Note that libraries like ActiveStorage will handle this for you.

However, be careful if users can download files named by _other_ users. Overall, it is safer to generate file names from known-safe values.

---
Back to [Warning Types](/docs/warning_types)

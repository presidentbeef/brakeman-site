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

---
Back to [Warning Types](/docs/warning_types)

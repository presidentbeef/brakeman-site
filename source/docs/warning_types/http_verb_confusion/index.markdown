---
layout: page
title: "HTTP Verb Confusion"
date: 2020-10-23 15:21
comments: false
sharing: true
footer: true
---

Ruby on Rails treats `HEAD` requests just like `GET` requests, except it drops the
response body and does not return it to the client _and_ `request.get?` returns `false`.

If code is assuming a request is either a `GET` or a `POST` and uses `request.get?` to check,
then a `HEAD` request will be treated like a `POST` instead of a `GET`.
This may trigger the wrong logic or allow a request to bypass CSRF protection
(since `GET`/`HEAD` requests are not protected).

[This post explains a vulnerability in GitHub](https://blog.teddykatz.com/2019/11/05/github-oauth-bypass.html)
arising from this confusion.

To avoid introducing a vulnerabilty with `request.get?`,
either use completely separate routes and actions for `GET` vs `POST` (preferred!):

```ruby
get '/some/path', to: 'my_controller#some_action'
post '/some/path', to: 'my_controller#a_different_action'
```


or else check `request.post?` explicitly:

```ruby
if request.get?
  # do something
elsif request.post?
  # do something else
end
```


---
Back to [Warning Types](/docs/warning_types)

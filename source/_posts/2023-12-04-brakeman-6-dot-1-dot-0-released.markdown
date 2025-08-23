---
layout: blog
title: Brakeman 6.1.0 Released
date: 2023-12-04 22:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 6.0.1
  changes:
  - Add check for unfiltered search with Ransack
  - Add `--timing` to add timing duration for scan steps
  - Add `PG::Connection.escape_string` as a SQL sanitization method ([Joévin Soulenq](https://github.com/joevin-slq-docto))
  - Handle `class << self`
  - Fix class method lookup in parent classes
  - Fix keyword splats in filter arguments
checksums:
- hash: 0d4066936dd58f0fe757d0ff1ec0744479be9ff06c771be4b581bdf0cb8d7403
  file: brakeman-6.1.0.gem
- hash: e7c9e739a43ec719d981e9b401b980c11cbe81a333ccb166965b9264ef413cc8
  file: brakeman-lib-6.1.0.gem
- hash: 709813eff010c9605dc09b9fcbe60742dd3b9e757ec7131808988a14b83eee23
  file: brakeman-min-6.1.0.gem
---


It's been a while!


## Ransack Searches

[Ransack](https://activerecord-hackery.github.io/ransack/) is a popular library for enabling search against ActiveRecord attributes.

It was originally intended for administrative interfaces (like those provided by ActiveAdmin).

Use usually looks like

```ruby
Car.ransack(params[:q])
```

And a url might look like

```
example.com?q[make_start]=vol
```

This might generate a query like

```sql
SELECT make FROM cars WHERE make LIKE 'vol%';
```

The library does clever things with the query parameter key.
In this case, `make` is the column and `start` means match values that start with the search term
passed in.

However, it's also possible to specify columns on related tables, such as

```
example.com?q[owner_name_start]=just
``` 

Which would search the `name` column on the `owners` table (assuming `Car` has an association to `Owner`).

Prior to Ransack 4.0, the default configuration allowed searching _all_ columns on a table as
well as _all_ columns on associated tables.

[Some folks figured out this can be used to extract secret values](https://positive.security/blog/ransack-data-exfiltration) by brute-forcing the value one character at a time.

To fix this issue, explicitly [allow list the attributes and associations available](https://activerecord-hackery.github.io/ransack/going-further/other-notes/#authorization-allowlistingdenylisting) to search.

In Ransack 4.0 and later, it is required to set up an allowlist.

Brakeman will warn about unrestricted use of `ransack`:

* **High** if no allow-listing methods are found in the class hierarchy of the model on which `ransack` is called
* **Medium** if the use happens to be in a file with `admin` in the path
* **Low** if the call to `ransack` is not on a class 

([changes](https://github.com/presidentbeef/brakeman/pull/1799))

## Timing Output

Use `--timing` to output duration of various steps during the scan.

Useful for debugging slowness.

([changes](https://github.com/presidentbeef/brakeman/pull/1801))

## Another SQL Escaping Method

Brakeman will not warn about use of `escape_string` in SQL queries. 

([changes](https://github.com/presidentbeef/brakeman/pull/1789))

## Class Methods

Brakeman will now treat methods defined inside of `class << self` as class methods.

This does mean fingerprints of warnings found inside those methods will change.

([changes](https://github.com/presidentbeef/brakeman/pull/1792))

## Class Method Lookups

Searching for class method definitions in parent classes will now actually look for class methods, not instance methods.

([changes](https://github.com/presidentbeef/brakeman/pull/1796))

## Keyword Splats in Filters

Code like

```ruby
before_action(**kwargs) do
  # ...
end
```

Will no longer cause an error.

([changes](https://github.com/presidentbeef/brakeman/pull/1800))


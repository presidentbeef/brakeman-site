---
layout: blog
title: Brakeman 2.4.0 Released
date: 2014-02-05 01:15
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 2.3.1
  changes:
  - " * Fingerprint attribute warnings individually ([Case Taintor](https://github.com/ctaintor))"
  - " * Add check for uses of `OpenSSL::SSL::VERIFY_NONE` ([Aaron Bedra](https://github.com/abedra/))"
  - " * Detect SQL injection raw SQL queries using `connection`([#434](https://github.com/presidentbeef/brakeman/issues/434))"
  - " * Fix false positives when SQL methods are not called on AR models ([#423](https://github.com/presidentbeef/brakeman/issues/423),
    [Aaron Bedra](https://github.com/abedra/))"
  - " * Reduce false positives for SQL injection in string building"
  - " * More accurate user input marking for SQL injection warnings"
  - " * Detect SQL injection in `delete_all`/`destroy_all`"
  - " * Add support for Rails LTS versions ([#422](https://github.com/presidentbeef/brakeman/issues/422))"
  - " * Parse exact versions from Gemfile.lock for all gems ([#431](https://github.com/presidentbeef/brakeman/issues/431))"
  - " * Ignore generators in `lib/` directory"
  - " * No longer raise exceptions if a class name cannot be determined"
  - " * Update to RubyParser 3.4.0"
---


This is a fairly big release with some significant changes (especially for SQL injection warnings), so please test carefully. Existing warnings and fingerprints may change.



## Attribute Warning Fingerprints

[Case Taintor](https://github.com/ctaintor) noted that ignoring one warning about dangerous mass assignable attributes ignored all such warnings for the same model. Then he fixed it, yay!

Please note this means fingerprints for warnings about "dangerous attributes" in `attr_accessible` will change. If you are currently ignoring some of these warnings, you will need to re-ignore them.

Also, the messages for these warnings have changed and the attribute name will now be in the "code" value in JSON reports.

([changes](https://github.com/presidentbeef/brakeman/pull/416))

## Check for SSL Verification

[Aaron Bedra](https://github.com/abedra/) has contributed a new check for instances of `verify_mode` on HTTPS connections being set to `OpenSSL::SSL::VERIFY_NONE`. This bypasses any checks OpenSSL has for verifying the SSL certificate is legitimate, allowing easy man-in-the-middle attacks.

This new check has a new warning type ("SSL Verification Bypass") and warning code (71).

([changes](https://github.com/presidentbeef/brakeman/pull/419))

## SQL Injection in Raw Queries

`ActiveRecord::Core#connection` or `ActiveRecord::Base.connection` or `ActiveRecord::Base#connection` can be used to send queries directly to the database connection without any protection. There are several ways of doing this, most of which are hopefully now covered by Brakeman.

([changes](https://github.com/presidentbeef/brakeman/pull/438))

## Fewer SQL Injection False Positives

Many changes were made in this release to reduce false positives related to SQL injection warnings and to improve the accuracy of reported issues.

First, [Aaron Bedra](https://github.com/abedra/) fixed Brakeman to not warn about query-like methods that were innocently called on non-ActiveRecord objects. ([changes](https://github.com/presidentbeef/brakeman/pull/426))

For example, this:

    find_by_sql("SELECT * FROM stuff WHERE thing = " + self.class.sanitize_sql(thing))

would have generated a warning which indicated `"SELECT * FROM stuff WHERE thing = " + self.class.sanitize_sql(thing)` was a dangerous value. Now it will not warn at all.

As another example, code like this

    options = {}

    if params[:sort_order] == 'ascending'
      sort_order = 'ASC'
    else
      sort_order = 'DESC'
    end

    options[:order] = 'updated_at ' + sort_order
    Test.all(options)

would create a warning about `("updated_at " + ("ASC" or "DESC"))`. Now Brakeman will recognize that these are all just strings and not warn.

Many warnings will also just be more accurate:

    query = "SELECT sum(stuff) " +
          "FROM (SELECT other_stuff FROM #{table} WHERE id = #{id}) " +
          "AS item, bgs " +
          "WHERE ST_Contains(item.geometry, bgs.the_point);"

    Test.find_by_sql(query)

This used to warn on the entire query! Now it will just warn about `table`.

`#to_s` calls are ignored now and their targets considered instead.

Additionally, Brakeman should no longer warn about method calls ending in `_id`, since those generally refer to foreign keys. Note, however, that local variables ending in `_id` will still produce warnings.

In general, fingerprints should not change for existing warnings, since the `user_input` value is not included in the fingerprint.

([changes](https://github.com/presidentbeef/brakeman/pull/440))

## SQL Injection in Deletions

Brakeman will now look for SQL injection in `delete_all` and `destroy_all` which allow raw SQL strings.

([changes](https://github.com/presidentbeef/brakeman/pull/438))

## Support for Rails LTS

[RailsLTS](https://railslts.com/) provides security patch backporting to Rails 2.3.18. They now [include an internal version number](http://makandracards.com/railslts/21809-how-to-find-out-your-current-rails-lts-version) in `Gemfile.lock`, which allows Brakeman to avoid warning about fixed vulnerabilities in applications using RailsLTS.

([changes](https://github.com/presidentbeef/brakeman/pull/437))

## Gemfile Parsing

Previously, Brakeman only checked `Gemfile.lock` for specific gems. Now it "parses" the entire file and can track all gem versions. ([bundler-audit](https://github.com/rubysec/bundler-audit) is recommended for checking gems for vulnerable versions.) This helps when Brakeman is checking for gem usage but the gem is an indirect dependency.

Also, a minor issue was fixed for those `Gemfile`s that do weird things and call `gem` with non-string arguments.

([changes](https://github.com/presidentbeef/brakeman/pull/432))

## Generators are Ignored

Any path in `lib/` containing `generators` will now be ignored. This is mainly because there are `.rb` files in there that are actually templates, but Brakeman tries to parse them and fails because they aren't really Ruby.

([changes](https://github.com/presidentbeef/brakeman/pull/427))

## Exceptions for Class Names

Previously, Brakeman actually raised and caught exceptions if a class name could not be determined from a `Sexp`. Now it just returns `nil`. This should remove some errors and possibly make some scans faster.

([changes](https://github.com/presidentbeef/brakeman/pull/417))

## RubyParser Update

The RubyParser dependency has been updated to 3.4.0. This release is *much* faster, along with [lots of other good changes](http://blog.zenspider.com/releases/2014/02/ruby_parser-version-3-4-0-has-been-released.html).

However, please note that line numbers for warnings involving heredocs may change. They will be slightly closer, but not exactly accurate.

([changes](https://github.com/presidentbeef/brakeman/commit/29239377a79bafbaddfa7664e1570d4c1f3982b5))

## SHAs

The SHA1 sums for this release are

c9d840b6fca08f61b3abbd1fa109cf66be19fccc  brakeman-2.4.0.gem
5bad89c43f7ab78bd40dfd6f71aac3d034ccaa0a  brakeman-min-2.4.0.gem

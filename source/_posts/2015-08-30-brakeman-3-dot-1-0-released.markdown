---
layout: post
title: "Brakeman 3.1.0 Released"
date: 2015-08-30 21:46
comments: true
categories: 
---

There are several changes in this release which may affect consumers of the JSON report as well as anyone relying on the ignore configuration file. Please try out [this script](https://gist.github.com/presidentbeef/52d5cce0fd26b901179e) to migrate ignore configurations.

Additionally, some dependencies have been updated to versions no longer supporting Ruby 1.8. As a consequence, Brakeman no longer runs "out of the box" on Ruby 1.8, although you may be able to use the `brakeman-min` gem. No more attempts will be made to support running on Ruby 1.8 in future releases. Please note that does not mean Ruby 1.8 code cannot be analyzed; that still works fine.

*Changes since 3.0.5*:

* Update dependencies to Ruby 1.8 incompatible versions
* Update render path information in JSON reports
* Remove renaming of several `Sexp` nodes
* Treat `html_safe` like `raw`
* Use railties version if rails gem is missing ([Lucas Mazza](https://github.com/lucasmazza))
* Warn about unverified SSL mode in `Net::HTTP.start`
* Expand XSS safe methods
* Avoid warning on path creation methods in `link_to`
* Add support for `gems.rb`/`gems.locked` ([#705](https://github.com/presidentbeef/brakeman/pull/705))
* Fix low confidence XSS warning code
* Avoid duplicate `eval` warnings
* Convert YAML config keys to symbols ([Karl Glaser](https://github.com/KarlGl))

### Ruby 1.8 Incompatibility

Ruby 1.8.7 has been unsupported by the Ruby core team for over a year now (and that was after it had a six month extension). Several libraries Brakeman depends on have stopped supporting Ruby 1.8. Unfortunately, there is no way to specify depending on different gem versions for different Ruby versions. This left Brakeman in a difficult place - use old libraries (and cause conflicts in Gemfiles...), use new libraries (and lose 1.8 support), or don't declare dependencies (and force users to install dependencies themselves). In the end, it seems most people are okay with dropping Ruby 1.8 support.

That being said, Brakeman 3.1.0 should run fine on Ruby 1.8 if dependencies are set up manually to be compatible.

([changes](https://github.com/presidentbeef/brakeman/pull/684))

### Render Path Improvements

Previously, render paths were arrays of strings. The strings represented the locations of calls to `render` (implicit or explicit), either in the form `<Controller>#<method>` or `Template:<template/path>`. While the information was somewhat useful to humans, it was not easily manipulated by computers and it was difficult to link the strings back to application code.

Now, render paths are arrays of hashes. The hash has a `type` key with a value of either `controller` or `template`. For controllers, the hash includes `class`, `method`, `line`, and `file`. For templates, the hash includes `name`, `line`, and `file`.

Example:

    [
      {
        "type": "controller",
        "class": "ProductsController",
        "method": "create",
        "line": 50,
        "file": "app/controllers/products_controller.rb"
      },
      {
        "type": "template",
        "name": "products/new",
        "line": 2,
        "file": "app/views/products/new.html.erb"
      }
    ]

Implicit renders from controller actions point to the line at the end of the method.

Rendered templates in JSON reports used to include the render location as well. For example:

    "location": {
      "type": "template",
      "template": "home/index (HomeController#index)"
    }

Since this information is redundant with the render path, it has been removed.

([changes](https://github.com/presidentbeef/brakeman/pull/702))

### S-Expression Names

Starting a long time ago, Brakeman rewrote several s-expression names for no reason other than clarity (for example, `dstr` becomes `string_interp`). However, not all nodes were changed, leading to code that must check for both the original name from RubyParser and Brakeman's name. This leads to messy code and subtle bugs.

The following node names were removed: `string_interp`, `string_eval`, `methdef`, `selfdef`, `call_with_block`.

While this seems like a silly internal change, it will unfortunately change any fingerprints containing these node types. A [quick script is available](https://gist.github.com/presidentbeef/52d5cce0fd26b901179e) to migrate ignore files without having to manually update the fingerprints.

([changes](https://github.com/presidentbeef/brakeman/pull/701))

### html_safe

As we hopefully all know now, `html_safe` is not safe, it marks a string so it is *not* escaped when output in a template. Since this is essentially the same as calling `raw` on a string, Brakeman will treat them both as unescaped output.

([changes](https://github.com/presidentbeef/brakeman/pull/675))

### Use railties Version

Thanks to [Lucas Mazza](https://github.com/lucasmazza), if an application depends on `railties` instead of `rails`, Brakeman will now use the gem version of `railties` as the Rails version.

([changes](https://github.com/presidentbeef/brakeman/pull/695/files))

### SSL Verify Mode

As suggested by [Gordon McNaughton](https://github.com/gmcnaughton), Brakeman now warns when SSL certificate verification is turned off in calls to `Net::HTTP.start`.

([changes](https://github.com/presidentbeef/brakeman/pull/694))

### Safe Methods

The `--safe-methods` option (which only applies to XSS warnings) and `--url-safe-methods` (which applies to values pass to `link_to`) now work on methods that have a target. For example, `--url-safe-methods this_is_safe` will ignore `link_to util.this_is_safe(params[:x])`.

([changes](https://github.com/presidentbeef/brakeman/pull/674))

### More Safe Methods

Brakeman warns about user input in the href parameter of `link_to` because it is possible to pass in a string starting with `javascript:`, which will execute the XSS payload when the victim clicks on it. However, it will no longer warn about methods that look like path helpers or URL generation methods. It will still warn about URL methods on models, since those may be direct user input.

([changes](https://github.com/presidentbeef/brakeman/pull/674))

### gems.rb/gems.locked

`gems.rb`/`gems.locked` are alternative names for `Gemfile`/`Gemfile.lock`. Brakeman now supports either pair.

([changes](https://github.com/presidentbeef/brakeman/pull/705))

### Weak Confidence XSS Warnings

A small bug caused weak confidence XSS warnings to have a warning code of `5` (which is for unescaped JSON) instead of `2`.

([changes](https://github.com/presidentbeef/brakeman/commit/9fec336e7cbbbb74add9ef9c6c90c65efa0ebcc7))

### Duplicate Eval Warnings

There should now be fewer duplicate warnings about dangerous calls to `eval`.

([changes](https://github.com/presidentbeef/brakeman/pull/670/files))

### Configuration Keys

[Karl Glaser](https://github.com/KarlGl) added a change so Brakeman configuration files may use string or symbol keys in the YAML file. However, it is recommended to use `brakeman -C` to generate configurations automatically, because writing YAML by hand is annoying.

([changes](https://github.com/presidentbeef/brakeman/pull/696))

### Internal Changes

Internally, most of the information Brakeman tracks is kept in hash tables. This is changing, starting with the addition of `Controller`, `Model`, `Template`, and `Config` classes.

Unfortunately, this will probably break any code that relies on Brakeman's internals (such as custom checks).

Fortunately, in almost all cases it will simplify code and in many cases it just means changing a hash access (like `template[:name]`) to a method call (`template.name`).

See [the pull request](https://github.com/presidentbeef/brakeman/pull/690) for examples.

Also note this is just the beginning of these internal changes...sorry! Hopefully this leads to improvements and makes it easier to write Brakeman code.

### SHAs

The SHA1 sums for this release are

    236af597e5cbcc0e647c02c4087ceb5965510435  brakeman-3.1.0.gem
    fe06faf67e781c4c4dc5ee362918ef2dfd8e1ce2  brakeman-min-3.1.0.gem

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues) with this release! Take a look at [this guide](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue) to reporting Brakeman problems.

Also consider following [@brakeman](https://twitter.com/brakeman) on Twitter and joining the [mailing list](http://brakemanscanner.org/contact/). 


---
layout: post
title: "Brakeman 1.5.3 Released"
date: 2012-04-10 13:18
comments: true
categories: 
---

A considerable number of bugs and odd cases have been fixed with this release, and one new check has been added. Upgrading is _always_ recommended!

_Changes since 1.5.2:_

 * Add check for user input in `Object#send` (Neil Matatall)
 * Support output to multiple formats (Nick Green)
 * Prevent infinite loops in mutually recursive templates
 * Only check `eval` arguments for user input, not the call target
 * Handle `render :layout` in views
 * Search subdirectories for models
 * Set values in request hashes and propagate to views
 * Add rake task file to gemspec (Anton Ageev)
 * Filter rescanning of templates (Neil Matatall)
 * Improve handling of modules and nesting
 * Test for zero errors in test reports

### New Check for User Input in Object#send

This new check looks for instances where user input can be used to control the method called using `send`.

For example:

    user = User.find(params[:user][:id])
    method = params[:user][:action].to_sym
    user.send(method)

### Support for Multiple Output Formats

Brakeman can now accept multiple `-o` arguments in order to produce more than one report from the same scan:

    brakeman -o report.html -o report.json

### Handle Mutually Recursive Templates

In some cases where two templates would render each other as partials, it would cause infinite loops in Brakeman. This is now fixed, at least for the simple common case:

\_one.erb.html:

    <%= render :partial => 'two' %>

\_two.erb.html:
    
    <%= render :partial => 'one' %>

### Only Check `eval` Arguments

Previously, Brakeman was checking the entire call to methods like `eval` or `class_eval` for user input. This led to false positives when `class_eval` was being called on a model.

Now Brakeman only checks the arguments or block provided to the `eval` call.

### Handle render :layout in views

Brakeman was not handling `render :layout => "..."` in views properly. This led to errors like:

    wrong number of arguments (0 for 1): /Users/collins/work/brakeman/lib/brakeman/processors/lib/render_helper.rb:14:in `template_name

`render :layout` is now handled just like rendering a partial.

### Search for Models in Subdirectories

Brakeman was only searching `app/models/` for models, but not any subdirectories. Now it does!

### Propagate Request Values

While Brakeman has always detected request values (e.g., query parameters) in views, it would not propagate values stored IN those request hashes.

For example, if an action in a controller did this:

    params[:input] = some_random_value

That value would not be propagated to the view if the view used `params[:input]`.

### Add Rake Task to Gemspec

In 1.2.0, Brakeman added the `--rake` option to add a Rake task to a Rails application, but the actual task itself was not included in the gem!

Thanks to Anton Ageev for pointing this out. Either no one else tried this option, or a lot of people were very disappointed. 

### Filter Templates When Rescanning

When rescanning (for example, with [guard-brakeman](https://github.com/guard/guard-brakeman)), Brakeman was assuming any files in `app/views` is a template, but this isn't always true.

### Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman/issues)!

Also consider joining the [mailing list](http://brakemanscanner.org/contact/) or following [@brakeman](https://twitter.com/brakeman) on Twitter.

And don't forget to check out the Brakeman talk at [RailsConf](http://railsconf2012.com/sessions/44) later this month.

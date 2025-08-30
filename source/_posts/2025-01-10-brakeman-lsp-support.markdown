---
layout: blog
title: "Brakeman LSP Support"
date: 2025-01-10 09:23
permalink: "/blog/:year/:month/:day/:title"
---

Announcing the [ruby-lsp-brakeman](https://github.com/presidentbeef/ruby-lsp-brakeman) project!

This new gem allows Brakeman scans to be integrated into code editors via [ruby-lsp](https://shopify.github.io/ruby-lsp/). Scans will run asynchronously in the background and warnings will can be shown inline in the editor.

## Using Ruby-LSP-Brakeman

Add `ruby-lsp-brakeman` to your `Gemfile`:

```ruby
gem 'ruby-lsp-brakeman', require: false
```

### In VS Code

If using with VS Code, make sure to install the [Ruby LSP extension](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-lsp).

`bundle install` and then restart the Ruby LSP extension to enable the add-on.

To double-check that Brakeman is running, examine the `output` tab in the VS Code panel for output like:

```
[info] (example-app) Finished initializing Ruby LSP!
[info] (example-app) [Brakeman] Activated Ruby LSP Brakeman, running initial scan
[info] (example-app) [Brakeman] Initial Brakeman scan complete - 0 warnings found
```

When files are saved, there should be logs like:

```
[info] (example-app) [Brakeman] Queued example-app/app/controllers/some_controller.rb
[info] (example-app) [Brakeman] Rescanning example-app/app/controllers/some_controller.rb
[info] (example-app) [Brakeman] Rescanned example-app/app/controllers/some_controller.rb
[info] (example-app) [Brakeman] Warnings: 0 new, 1 fixed, 2 total
```

Findings will show up with squiggly underlines:

![Inline Brakeman warning in VS Code](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hqftm3nn87fekg79in2s.png)

## Background Information

Just for those interested in what's going on behind the scenes!

### Language Server Protocol

[Language Server Protocol (LSP)](https://microsoft.github.io/language-server-protocol/) is a standard for communication between code editors and code-related tools. It enables tools to hook into standard events for code review, code completion, formatting, etc.

In the Ruby world, Shopify's `ruby-lsp` provides a convenient implementation of LSP and the ability to build "add-ons" like `ruby-lsp-brakeman`.

### How Brakeman is Integrated

The Brakeman add-on primarily hooks into the file change monitoring, which is triggered when a file is saved or deleted. The file is then added to a queue for rescanning. All files in the queue will be rescanned in the next scan. This is to avoid either triggering multiple concurrent scans or missing file updates because a scan was already in progress.

When the scan is complete, the warnings are reported back as a "[diagnostic](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#diagnostic)" to be displayed in the editor.

Interestingly, it's also necessary to return _empty_ sets of diagnostics (per changed file) to clear any fixed warnings that were previously reported.

### Brakeman Rescanning

Unlike some other code review or formatting tools, Brakeman works across the entire application, not one file at a time. Code in one file can have effects elsewhere in the application.

A long time ago, "rescanning"/incremental scans were added to Brakeman. To achieve this, Brakeman needs to keep the entire state of the scan in memory, then attempt to update only the relevant information as files change. (This is as opposed to running scans on only a subset of files or caching results offline somehow. Side note: do not use `--only-files` to try to make this work!)

To know what to update internally, Brakeman would try to guess based on the file that changed (including cascading effects). This was always pretty heavy on heuristics and not very well tested. But it kind of mostly worked!

All the way back in Brakeman 5.0, the scan implementation moved away from using file names and paths to determine the type of file (e.g., controllers vs. models) to using the contents of the file instead. However, the re-scanning was not updated to use this information. Since it was still operating based on file paths, it was no longer aligned with the files being scanned by Brakeman normally.

What all this means is that rescanning has been in a broken and slowly deteriorating state since Brakeman 5.0!

With Brakeman 7.0, rescanning has been revised. For now, rescanning focuses on caching parsed files and only re-parsing changed files. The rest of the scan starts from "scratch". Finding, reading, and parsing files is often one of the slowest parts of scans, so this should still save time for most folks.

Since caching all the parsed files introduces a bit of memory overhead, the functionality is off by default. To enable, initial scans must be run with `support_rescanning: true`.

Hopefully future work will be able to expand out the "incremental" part of rescanning again.

## What's Next

While the add-on generally works with VS Code, I'd love to polish it up a bit more and move to a 1.0 release.

I'm also considering if `ruby-lsp-brakeman` should depend on Brakeman, or if it should actually be a Brakeman dependency so everyone has it available by default. Let me know if you have thoughts on that.

Please help by testing out [ruby-lsp-brakeman](https://github.com/presidentbeef/ruby-lsp-brakeman) and [sharing any feedback/bugs](https://github.com/presidentbeef/ruby-lsp-brakeman)!

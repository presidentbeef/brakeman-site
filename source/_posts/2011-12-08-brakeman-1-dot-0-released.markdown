---
layout: blog
title: "Brakeman 1.0 Released!"
date: 2011-12-08 01:35
comments: true
categories: 
permalink: /blog/:year/:month/:day/:title
---


<p>While the step up to 1.0 was essentially forced by major changes since 0.9.2, this is still an important release for Brakeman. Internally, Brakeman is no longer reliant on a global options variable, allowing it to be used as a library inside other applications. Also, all Brakeman modules, classes, and constants have been placed inside the Brakeman namespace.</p>

<p>Support for Rails 3 is continuing to improve, although it is probably a good idea to run Brakeman with the <code>-m</code> option to see what routes it is seeing. If you receive a message that says &#8220;Error while processing routes - assuming all public controller methods are actions,&#8221; please consider opening an issue and (if possible) providing your <code>routes.rb</code> file as evidence.</p>

<p>The performance of vulnerability checks that search for calls to specific methods (CheckExecute, CheckFileAccess, CheckSQL, etc.) has been drastically improved with the introduction of a call site index. If your scans were spending a lot of time running checks, you should see significant decrease in run time (although memory use may be slightly higher).</p>

<p>If you are looking for an introduction to Brakeman, there are some <a href="http://brakemanscanner.org/docs/presentations/">presentations available</a> to watch or read.</p>

<p>As usual, please <a href="https://github.com/presidentbeef/brakeman/issues">report</a> any issues! You can also send a tweet to <a href="http://twitter.com/brakeman">@Brakeman</a> if you have any questions.</p>

<p><em>Changes since 1.0rc1:</em></p>

<ul>
<li>Better handling of assignments inside ifs</li>
<li>Check more expressions for SQL injection</li>
<li>Use latest ruby_parser for better 1.9 syntax support</li>
<li>Better behavior for Brakeman as a library</li>
</ul>


<h3>Assignments Inside &#8216;if&#8217; Branches</h3>

<p>Brakeman is now a little smarter about handling assignments inside <code>if</code>.</p>

<p>For example:</p>

<pre><code>if some_condition
  x = params[:blah]
else
  x = "no blah"
end
</code></pre>

<p>Previously, <code>x</code> would end up with the last value encountered, with no regard for execution branches. In this release, Brakeman will now combine the branches (unfortunately, Brakeman still operates along a &#8216;no branching&#8217; policy) and <code>x</code> will be given the value of <code>params[:blah] or "no blah"</code>.</p>

<p>While not strictly semantically sound (and, trust me, Brakeman does many things that are not), it will still catch problems like</p>

<pre><code>User.all(conditions =&gt; "blah = '#{x}'")
</code></pre>

<p>Thanks to <a href="http://osdir.com/ml/RubyonRails:Core/2011-11/msg00098.html">this message</a> on Rails Core for mentioning this problem.</p>

<h3>Use Latest ruby_parser</h3>

<p>A few releases ago, Brakeman included a slightly modified version of <a href="https://github.com/seattlerb/ruby_parser">ruby_parser</a> to help with Ruby 1.9 syntax issues.</p>

<p>The very latest ruby_parser source has much better 1.9 support, but there has been no official release yet. So Brakeman comes with the latest code. This is necessary because Rails 3 will generate 1.9 syntax if you happen to run it with Ruby 1.9 when generating code.</p>

<h3>Brakeman as a Library</h3>

<p>While it is now possible to use Brakeman as a library (essentially just <code>Brakeman.run</code>), it is not very well polished. This release improves it slightly from the release candidate.</p>

<h3>More SQL Injection</h3>

<p><code>CheckSQL</code> will now search most expressions inside a SQL call for user input and string interpolation.</p>

<h3>Changes Since 0.9.2</h3>

<p>As a summary, here are the changes since 0.9.2:</p>

<ul>
<li>Brakeman can now be used as a library</li>
<li>Faster call search</li>
<li>Add option to return error code if warnings are found (tw-ngreen)</li>
<li>Allow truncated messages to be expanded in HTML</li>
<li>Keep expanded context in view in HTML output</li>
<li>Fix summary when using warning thresholds</li>
<li>Better support for Rails 3 routes</li>
<li>Reduce SQL injection duplicate warnings</li>
<li>Lower confidence on mass assignment with no user input</li>
<li>Ignore mass assignment using all literal arguments</li>
</ul>


<p>See the <a href="http://brakemanscanner.org/blog/2011/12/05/brakeman-1-dot-0-release-candidate-available/">earlier post</a> for more details.</p>

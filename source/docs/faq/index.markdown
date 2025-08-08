---
layout: docs
title: "Frequently Asked Questions"
date: 2011-08-27 08:29
comments: true
sharing: true
footer: false
---

### Brakeman hangs while processing my app. What do I do?

Sorry about that! Please follow [these instructions](/docs/troubleshooting/hanging).

### Brakeman is reporting parsing errors, but my app runs fine. What's going on?

Brakeman relies on [RubyParser](https://github.com/seattlerb/ruby_parser) for parsing Ruby code. RubyParser can lag behind the latest syntax changes in Ruby. 

By the way, sometimes there are actual syntax errors! This can happen in code which is no longer used by the application.

Please follow [these instructions](/docs/troubleshooting/parse_errors) to find out what went wrong.

### What is the number in parentheses (red in HTML) in the report summary?

That number indicates how many high confidence warnings were found.

### Why are line numbers reported wrong?

Line numbers are sometimes off. This can be due to the parser reporting the wrong line number, or occasionally there is a bug in Brakeman.

However, it is important to note that the line number reported is where the vulnerability was found, not necessarily where it was introduced. For example, if a SQL query uses string interpolation which was assigned to a variable, the line with the query will be reported, not where the string is constructed.

### Why is the context so different from the code shown in the warning?

The code in the warning is what is seen by Brakeman, while the code in the context is pulled directly from the original file. These can be different, as Brakeman propagates variables and performs other transformations on the code.

### What is an "Unresolved Model"?

"Unresolved Model" is a placeholder used when it is clear that a model is being used at that location, but there is no way to know which model it is.

### Why is a variable shown as "SomeModel.new" when it clearly is not?

Records from a model will be sometimes displayed this way. 

For example, if `User` is a model and there is an action like

    class UsersController

      def list
        @users = User.all
      end

    end

and a corresponding view containing

    <% @users.each do |user| %>
      <%= user.name.html_safe %>
    <% end %>

This will produce a warning that looks like

    Unescaped model attribute near line 3: User.new.name

### Brakeman reports 0 warnings. Am I safe?

**No**. It just means Brakeman didn't find any problems. There are many vulnerabilities Brakeman cannot find. No security tool has 100% coverage.

---

[More documentation](/docs)

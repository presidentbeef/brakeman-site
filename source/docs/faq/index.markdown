---
layout: page
title: "Frequently Asked Questions"
date: 2011-08-27 08:29
comments: false
sharing: false
footer: false
---

### What is the number in parentheses (red in HTML) in the report summary?

That number indicates how many high confidence warnings were found.

### Why are line numbers reported wrong?

Line numbers are sometimes off. This can be due to the [parser](http://rubyforge.org/tracker/index.php?func=detail&aid=26435&group_id=439&atid=1778) reporting the wrong line number, or occasionally there is a bug in brakeman.

However, it is important to note that the line number reported is where the vulnerability was found, not necessarily where it was introduced. For example, if a SQL query uses string interpolation which was assigned to a variable, the line with the query will be reported, not where the string is constructed.

### Why is the context so different from the code shown in the warning?

The code in the warning is what is seen by brakeman, while the code in the context is pulled directly from the original file. These can be different, as brakeman propagates variables and performs other transformations on the code.

### What is an "Unresolved Model"?

"Unresolved Model" is a placeholder used when it is clear that a model is being used at that location, but there is no way to know which model it is.

### Why is a variable shown as "SomeModel.new" when it clearly is not?

Records from a model will be sometimes displayed this way. This happens, for example, when a collection of query results is being iterated over.

### Brakeman reports 0 warnings. Am I safe?

**No**. It just means Brakeman didn't find any problems. There may be vulnerabilities Brakeman does not test for or did not discover. No security tool has 100% coverage.

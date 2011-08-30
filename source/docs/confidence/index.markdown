---
layout: page
title: "Confidence Levels"
date: 2011-08-27 08:18
comments: false
sharing: false
footer: true
---

Brakeman assigns each warning a confidence level. This rating is intended to indicate how certain Brakeman is that the given warning is a real problem.

The following guidelines are used:

 * High - Either this is a simple warning or user input is very likely being used in unsafe ways.
 * Medium - This generally indicates an unsafe use of a variable, but the variable may or may not be user input.
 * Weak - Typically means user input was indirectly used in a potentially unsafe manner.

However, Brakeman can easily guess wrong, so it is best to read through all warnings and assess their importance manually.

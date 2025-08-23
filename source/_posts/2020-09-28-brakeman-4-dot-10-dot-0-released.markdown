---
layout: blog
title: Brakeman 4.10.0 Released
date: 2020-09-28 12:30
permalink: "/blog/:year/:month/:day/:title"
changelog:
  since: 4.9.1
  changes:
  - Add SARIF report format ([Steve Winton](https://github.com/swinton))
checksums:
- hash: 7bef7df71137d06be5fc3325ead57f8ce35be7691bf6dd389228461d731b79dd
  file: brakeman-4.10.0.gem
- hash: 698b8eb02cdea7a6e407192c261c61d8fc6cd24d590a1b388defc9de17966119
  file: brakeman-lib-4.10.0.gem
- hash: 64bb565ee84b9a9646985e456db1125ff9fb884ca83de6ba6fbc2c63bdbc8de9
  file: brakeman-min-4.10.0.gem
---


This release introduces a new report format!


## SARIF Report Format

[Steve Winton](https://github.com/swinton) from GitHub has contributed support for [Static Analysis Results Interchange Format (SARIF)](https://sarifweb.azurewebsites.net/).
This is a standard format for static analysis tools and can be consumed by some report viewers, such as [this one for Visual Studio Code](https://github.com/Microsoft/sarif-vscode-extension/).

To output a SARIF report, use `-f sarif` or a file name like `-o report.sarif`.

([changes](https://github.com/presidentbeef/brakeman/pull/1500))

## Previewing Brakeman 5.0

_What is planned for Brakeman 5.0?_

The big change coming in 5.0 is scanning _way_ more files. Currently, Brakeman scans specific directories in `app/`, `config/`, `lib/`, and `engines/`.
It also only looks for files in particular places - e.g. views will be somewhere in `app/**/views`.

In 5.0, Brakeman will scan (almost) all files in the project directory with `.rb` or template-related extensions.
This will dramatically increase the scope of Brakeman scans, which is better coverage but at the cost of more false positives and slower scans.

Also expected in Brakeman 5.0 is a bump of minimum Ruby version to 2.4.0 (which is already EOL).


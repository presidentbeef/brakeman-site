---
layout: blog
title: "Brakeman 8.0.6"
subtitle: "A few bug fixes"
date: 2026-08-12
version: "8.0.6"
changelog:
  since: "8.0.5"
  changes:
    - "Fix EOL date for Rails 8.0 ([yeaseul-kim](https://github.com/yeaseul-kim))"
    - "Fix command injection false positives ([Jacob Evelyn](https://github.com/JacobEvelyn))"
    - "Add EOL dates for Rails 8.1 and Ruby 4.0"
    - "Fix unused variable warning ([@viralpraxis](https://github.com/viralpraxis))"
checksums:
  - hash: "759cc69341115e6c2dcd47b6fd8649a0b9bd540e3585ac8a0a94e31c66fee386"
    file: "brakeman-8.0.6.gem"
  - hash: "f56697ed48543f58aa4d3d9d9a7929cab99f8ddb273479ab8f06877de077b240"
    file: "brakeman-lib-8.0.6.gem"
  - hash: "efb425199579777757ed32aade4e7b4663d1475f08c7b6f1f3d0b74ec2ec1205"
    file: "brakeman-min-8.0.6.gem"
permalink: /blog/:year/:month/:day/:title
---

### Rails 8.0 EOL Date

Changed from October 7, 2026 to **November 7**, 2026.

([changes](https://github.com/presidentbeef/brakeman/pull/2034))

### Command Injection False Positives

Jacob fixed some false positives when command-excuting methods like `spawn`, `popen2`, `capture2`, etc. are used safely.

([changes](https://github.com/presidentbeef/brakeman/pull/2022)) 

### EOL Dates for Rails 8.1 and Ruby 4.0

They have been added.

([changes](https://github.com/presidentbeef/brakeman/pull/2033))

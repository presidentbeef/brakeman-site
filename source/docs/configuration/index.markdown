---
layout: docs
title: "Configuration Files"
---

Brakeman options can be stored and read from YAML files. To simplify the process of writing a configuration file, the `-C` option will output the currently set options.

Options passed in on the commandline have priority over configuration files.

The default config locations are `./config/brakeman.yml`, `~/.brakeman/config.yml`, and `/etc/brakeman/config.yml`

The `-c` option can be used to specify a configuration file to use.



---
layout: post
title: "Brakeman 3.0.1 Released"
date: 2015-01-22 18:38
comments: true
categories: 
---

This is a small release, but may change some fingerprints of warnings in libraries. Also, the Slim dependency has been removed due to conflicts. See below for details.

* Remove Slim dependency ([Casey West](https://github.com/cwest))
* Properly process libraries ([Patrick Toomey](https://github.com/ptoomey3))
* Add `--add-libs-path` for additional libraries  
* Allow for controllers/models/templates in directories under `app/` ([Neal Harris](https://github.com/nealharris))
* Avoid `protect_from_forgery` warning unless `ApplicationController` inherits from `ActionController::Base` ([#573](https://github.com/presidentbeef/brakeman/issues/573))
* Properly format command interpolation (again)

### Slim Gem Dependency Removed

Since [Rails 4.2 requires Slim 3.0.1](https://github.com/slim-template/slim-rails/releases/tag/3.0.1) and [Slim 3.0 dropped support for Ruby 1.8.7](https://github.com/slim-template/slim/blob/bb7ca78c1ea9629d8b57a06fcb99c938c9d7640e/CHANGES#L8), there is no way to satisfy dependencies for Slim, Rails 4.2, and retain support for Ruby 1.8.7 when Brakeman is added as a dependency in a `Gemfile`.

The only acceptable solution is to not include Slim as a dependency at all and let users sort it out for themselves. Sorry for the unfortunate situation, but there is no way to add Brakeman to a `Gemfile` and avoid Bundler attempting to resolve Brakeman's dependencies against the application's dependencies, despite there being no relation.

([changes](https://github.com/presidentbeef/brakeman/pull/602))

### Library Processing

Libraries were added to the call index (which meant they were scanned during checks) in the 3.0.0 release, but there were still not being processed like most other code. This led to some checks not finding issues they should have.

This change may affect existing warning fingerprints for warnings in libraries. Apologies for the inconvenience. 

([changes](

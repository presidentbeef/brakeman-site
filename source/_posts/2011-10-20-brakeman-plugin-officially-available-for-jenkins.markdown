---
layout: post
title: "Brakeman Plugin 'Officially' Available for Jenkins"
date: 2011-10-21 11:54
comments: true
categories: 
---

While a Brakeman plugin for the [Jenkins](http://jenkins-ci.org)/[Hudson](http://hudson-ci.org) continuous integration tool has been available since January, thanks to [some prodding](https://github.com/presidentbeef/brakeman-jenkins-plugin/issues/1) the plugin is now available through the official Jenkins plugin manager.

![Example Plugin Graph](images/brakeman_trend_graph.png "Example Plugin Graph")

Installation of the plugin is no longer an arduous manual process. Just go to `Manage Jenkins -> Manage Plugins -> Available` and search for "Brakeman". Check the box and then click the "Install" button down at the bottom of the page.

Some more information about the plugin can be found on the [Jenkins wiki](https://wiki.jenkins-ci.org/display/JENKINS/Brakeman+Plugin).

See the [instructions](docs/jenkins/setup) for how to set up a job to use the Brakeman plugin.

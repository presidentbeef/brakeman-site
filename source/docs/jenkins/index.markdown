---
layout: page
title: "Running Brakeman with Jenkins"
date: 2021-01-04 10:26
comments: false
sharing: false
footer: true
---

Collecting and managing Brakeman results in [Jenkins](https://www.jenkins.io/) is supported by the [Warnings Next Generation Plugin](https://plugins.jenkins.io/warnings-ng/).

![Brakeman results in Jenkins](/images/jenkins/Jenkins-0-overview.png "Brakeman results in Jenkins")

### Installing the Plugin

In the Jenkins Plugin Manager, install the "Warnings Next Generation Plugin".

![Warnings Next Generation Plugin](/images/jenkins/Jenkins-0-install-plugin.png "Warnings Next Generation Plugin")

### Running Brakeman in Jenkins

The plugin itself does not run any tools, it just collects the results.

There are many ways to run Brakeman in Jenkins, depending on the setup on your application and the Jenkins workers.

One method is to invoke Brakeman as part of an "Execute shell" build step:

![Add build step](/images/jenkins/Jenkins-1-build-step.png "Add build step")

![Execute shell](/images/jenkins/Jenkins-2-execute-shell.png "Execute shell command to run Brakeman")

Here is a sample build command if [RVM](https://rvm.io/) is available on the worker:

```
bash -l -c '
rvm install 3.0.0 && \
rvm use 3.0.0@brakeman --create && \
gem install brakeman && \
brakeman --no-progress --no-pager --no-exit-on-warn -o brakeman-output.json
'
```

Explanation of Brakeman options:

* `--no-progress` avoids ugly `Processing...` output in Jenkins logs
* `--no-pager` avoids invoking `less` to display report
* `--no-exit-on-warn` tells Brakeman to return a 0 exit code even if warnings are found
* `-o brakeman-output.json` sets the report file and format

### Collecting Results 

To configure the plugin, click "Add post-build action" and select "Record compiler warnings and static analysis results".

![Post-build action](/images/jenkins/Jenkins-3-post-build-step.png "Post-build action")

Then select "Brakeman" as the tool.

![Select Brakeman](/images/jenkins/Jenkins-4-select-brakeman.png "Select Brakeman as a tool")

The default options will check for files named `brakeman-output.json` and collect the results.

There is no need to set any other configuration options right now.
By default, the plugin will collect and display results but will not affect the status of the build.

Click the "Advanced..." button to check out the _many_ options for configuring how Brakeman results affect build status.

### Viewing Results

After the next build, Brakeman results should appear in the build status.

![Brakeman Warnings Status](/images/jenkins/Jenkins-5-status-result.png "Brakeman Warnings Status")

On subsequent builds, the plugin will show if there are new and/or fixed warnings in that build.

![Brakeman New Warnings](/images/jenkins/Jenkins-6-status-change.png "New Warnings")

The plugin can show warnings broken down by folder, file, category, type, or just a list of issues.

![Warnings Overview](/images/jenkins/Jenkins-7-warnings-overview.png "Brakeman Warnings Overview")

The overview will show a breakdown of warnings by severity or status (fixed/new/existing).
Note that the plugin maps "medium" findings to "normal" and "weak" findings to "low".

Warnings can also be viewed inline with code:

![Inline Warnings](/images/jenkins/Jenkins-8-warnings-inline.png "Inline Brakeman Warnings")


### More Information

See the [documentation for the Warnings Next Generation Plugin](https://plugins.jenkins.io/warnings-ng/).

---

[Back to More documentation](/docs)

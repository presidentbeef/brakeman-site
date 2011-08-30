---
layout: page
title: "Introduction to Brakeman"
date: 2011-08-30 11:37
comments: false
sharing: true
footer: true
---

Brakeman is a security scanner for Ruby on Rails applications.

Unlike many web security scanners, Brakeman looks at the source code of your application. This means you do not need to set up your whole application stack to use it.

Once Brakeman scans the application code, it produces a report of all security issues it has found.

## Advantages

### No Configuration Necessary

Brakeman requires zero setup or configuration once it is installed. Just run it.

### Run It Anytime

Because all Brakeman needs is source code, Brakeman can be run at any stage of development: you can generate a new application with `rails new` and immediately check it with Brakeman.

### Better Coverage

Since Brakeman does not rely on spidering sites to determine all their pages, it can provide more complete coverage of an application. This includes pages which may not be 'live' yet. In theory, Brakeman can find security vulnerabilities *before* they become exploitable.

### Best Practices

Brakeman is specifically built for Ruby on Rails applications, so it can easily check configuration settings for best practices.

### Flexible Testing

Each check performed by Brakeman is independent, so testing can be limited to a subset of all the checks Brakeman comes with.

### Speed

While Brakeman may not be exceptionally speedy, it is much faster than "black box" website scanners. Even large applications should not take more than a few minutes to scan.

## Limitations

### False Positives

Only the developers of an application can understand if certain values are dangerous or not. By default, Brakeman is extremely suspicious. This can lead to many "false positives."

### Unusual Configurations

Brakeman assumes a "typical" Rails setup. There may be parts of an application which are missed because they do not fall within the normal Rails application layout.

### Only Knows Code

Dynamic vulnerability scanners which run against a live website are able to test the entire application stack, including the webserver and database. Naturally, Brakeman will not be able to report if a webserver or other software has security issues.

### Isn't Omniscient

Brakeman cannot understand everything which is happening in the code. Sometimes it just makes reasonable assumptions. It may miss things. It may misinterpret things. But it tries its best. Remember, if you run across something strange, feel free to file an [issue](https://github.com/presidentbeef/brakeman/issues) for it.

## Suggested Use

The best course of action is to use both Brakeman and a regular website security scanner. They are complementary approaches.

If you happen to use the Hudson/Jenkins continuous integration tool, there is a [Brakeman plugin](/docs/jenkins) for it.

---
layout: docs
title: "Ignoring False Positives"
---

False positives (warnings about potential vulnerabilities which are not actual vulnerabilities) are present in any security tool. Before ignoring a false positive, be certain it is actually a false positive and also consider [reporting it](https://github.com/presidentbeef/brakeman/wiki/How-to-Report-a-Brakeman-Issue#false-positivesfalse-negatives) in case changes can be made to Brakeman to prevent the false positive in the future.

The ignore configuration is a JSON file containing a list of warnings. This is essentially the same as the JSON report, except the warnings can also have a `note` field.

A minimal configuration might look like this, although the auto-generated one will have more information:

    {
        "ignored_warnings": [
            {
              "fingerprint": "a21418b38aa77ef73946105fb1c9e3623b7be67a2419b960793871587200cbcc",
              "note": "ignore foo"
            },
            {
              "fingerprint": "5945a9b096557ee5771c2dd12ea6cbec933b662d169e559f524ba01c44bf2452",
              "note": "ignore bar"
            }
        ]
    }

This functionality was introduced in [Brakeman 2.1.0](/blog/2013/07/17/brakeman-2-dot-1-0-released/).

## Creating and Managing an Ignore File

The `-I` option (or `--interactive-ignore` if you are not into the whole brevity thing) is the simplest way to create and manage an ignore configuration.

Use the `-I` option with a regular run of Brakeman.

After the scan, Brakeman will ask for an existing configuration file to load:

    Input file: |config/brakeman.ignore| 

Unless there is an existing file somewhere else, just press enter to continue. If the file does not exist, Brakeman will prompt

    No such file. Continue with empty config? 

Enter `y` unless there is an existing file.

Next, Brakeman will ask what to do:

    1. Inspect all warnings
    2. Hide previously ignored warnings
    3. Skip - use current ignore configuration
    ? 

Enter `1` to step through all warnings. Enter `2` to step through all warnings except those which were already ignored. Enter `3` to skip the whole process and leave things as-is.

For option `1` or `2`, Brakeman will now present each warning in turn and ask what to do with them:

![brakeman -I](/images/bm-I.png)

These are the options:

    i - Add warning to ignore list
    n - Add warning to ignore list and add note
    s - Skip this warning (will remain ignored or shown)
    u - Remove this warning from ignore list
    a - Ignore this warning and all remaining warnings
    k - Skip this warning and all remaining warnings
    q - Quit, do not update ignored warnings
    ? - Display this help

After stepping through the warnings, Brakeman will ask if the changes should be saved:

    1. Save changes
    2. Start over
    3. Quit, do not save changes
    ? 

Enter `1` to save the changes to a file. Enter `2` to step through the warnings again. Enter `3` to not save any changes.

For option `1`, Brakeman will ask where to save the file. The default `config/brakeman.ignore` is recommended.

After that, the scan report will be generated, with the specified warnings ignored.

## Specifying an Ignore File

By default, Brakeman will look in the `config` directory of the application being scanned for a file named `brakeman.ignore`. If this file exists, it will automatically be loaded and used.

Otherwise, the location of the configuration file can be set using `-i` or `--ignore-config` with the file name, relative to the root of the Rails application.

## When Warnings are Ignored

JSON reports include an array of `ignored_warnings`, HTML reports have a table of ignored warnings which is hidden by default, and the basic text output will include the number of warnings ignored, if any.

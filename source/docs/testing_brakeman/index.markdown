---
layout: docs
title: "Testing Brakeman"
date: 2012-02-09 10:02
comments: false
sharing: false
footer: true
---

Tests for Brakeman are written using the standard library's [test/unit](http://rubydoc.info/stdlib/test/1.8.7/Test/Unit).

The main test file is in `test/test.rb`. It can be run using `ruby test/test.rb` (or from any directory).

### Structure

Brakeman is tested by running it against full Rails applications and then checking the reported warnings.

    test/test.rb #Main test runner
    test/apps/   #Apps to check against
    test/tests/  #Actual tests

There are several Rails applications, including:

    test/apps/rails2    #Rails 2.3.11
    test/apps/rails3    #Rails 3.0.5
    test/apps/rails3.1  #Rails 3.1.0

There are corresponding sets of tests for each application:

    test/tests/rails2.rb
    test/tests/rails3.rb
    test/tests/rails31.rb

### Test Setup

Each of the test files starts off like this:

    class Rails3Tests < Test::Unit::TestCase
      include BrakemanTester::FindWarning
      include BrakemanTester::CheckExpected
    
      def report
        @@report ||= BrakemanTester.run_scan "rails3", "Rails 3"
      end

      def expected
        @expected ||= {
          :controller => 1,
          :model => 5,
          :template => 18,
          :warning => 22
        }
      end

The `report` method runs the scan once. The first argument is the directory of the application, assumed to be under `test/apps/`. The second argument is just a name for the application. After that, any options that would normally be given to `Brakeman.run` can be provided.

The result of `BrakemanTester.run_scan` is a big hash of the warnings found during the scan. This is generated using `Brakeman::Report#to_test`.

Two modules are included in the test suite. `FindWarning` provides a search capability for finding warnings in the report. `CheckExpected` calls `expected` and checks the numbers there against the actual report.

### Testing a Warning

To test for the presence of a warning, use the `assert_warning` method. This method takes a hash of options describing the warning:

    def test_eval_params
      assert_warning :type => :warning,
        :warning_code => 13,
        :fingerprint => "4efdd73fb759135f5980b5da1d9804aa4eb5c7475eabfd0f0cf41299d1d7ec42",
        :warning_type => "Dangerous Eval",
        :line => 41,
        :message => /^User input in eval near line 41: eval\(pa/,
        :confidence => 0,
        :file => /home_controller\.rb/
    end

Each key in the hash is a method on `Brakeman::Warning`, except `:type`. The value will be tested using `===` against the result of calling the method. This means regular expressions can be used to match against strings.

It is best to be as specific as possible, because `assert_warning` expects *exactly* one warning to match.

Options:

 * `:type` - This determines which category of warnings to search (controller, model, template, or just 'warning')
 * `:fingerprint` - The warning fingerprint
 * `:warning_code` - Integer representing the warning type
 * `:warning_type` - This matches against the category of warning
 * `:line` - The line number reported in the warning
 * `:message` - The text of the warning message
 * `:confidence` - Confidence level (0 - high, 1 - medium, 3 - weak)
 * `:file` - File where warning was found

For the message matching, it is generally enough to just include the first part of the message, instead of trying for an exact match.

For the file name, generally just the name of the file (without the path) is used, although it is matched against the full path.

---

[More documentation](/docs)

[Adding tests](/docs/contributing/adding_tests)

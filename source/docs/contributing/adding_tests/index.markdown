---
layout: docs
title: "Adding New Tests"
---

Please see [this page](/docs/testing_brakeman) for details about how Brakeman is tested.

### File Locations

The test applications are located in `test/apps/`.

Corresponding tests are located in `test/tests/`.

### Adding an Undetected Vulnerability

Most of the time, improvements to Brakeman mean finding more vulnerabilities.

If possible, a real-life test case makes this much easier to implement.

To add a new vulnerability and verify that Brakeman does not alert on it, choose one of the Rails applications in `test/apps` according to the version desired and add some vulnerable code to it.

There is no real strict structure to the applications, so add the vulnerability wherever it makes sense. Adding new files as needed is fine.

**IMPORTANT**: If adding a vulnerability to an existing file, make sure it is *below* any existing code containing vulnerabilities. Shifting any existing lines will cause all those tests to fail!

Once the new vulnerability has been added, run `test/test.rb`. If all the tests pass, the new vulnerability has not been detected. This can be verified by running Brakeman directly against the application.

However, if a test fails like this:

    1) Failure:
     test_number_of_warnings(Rails2Tests) [test.rb:84]:
     Expected 22 warning warnings, but found 23.
     <22> expected but was
     <23>.

Then the vulnerability probably was detected. Again, verify by using Brakeman directly.

If the vulnerability was not detected, please [file an issue](https://github.com/presidentbeef/brakeman/issues) for it!

### Adding a Known Vulnerability

There may be categories of Brakeman that does detect, but is not covered by the current tests. OR, you are planning on submitting a new feature or check that will find more vulnerabilities.

Again, this vulnerability should be added to one of the existing applications in `test/apps`. If the vulnerability differs according to version, it may make sense to add it to more than one application.

Once the vulnerability is introduced, run both `test/test.rb` and Brakeman directly against the code. Hopefully the tests show more warnings than expected, and the new vulnerability shows up in the Brakeman report.

Now it is time to add a test for the warning.

In the appropriate test suite under `test/tests`, add a new test for the warning. See [this page](/docs/testing_brakeman) for information on how to do this.

### Adding a False Positive

This should follow the same process as adding a known vulnerability. However, when it comes time to add the test for the warning, use `assert_no_warning` instead of `assert_warning`.

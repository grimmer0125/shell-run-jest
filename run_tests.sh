#!/bin/bash

# Run Jest tests and store the exit code (0 for success, 1 for failure)
# jest output is usually in stderr, even if the test passes
npm test -- test/example.test.js > stdout.txt 2> stderr.txt
# https://stackoverflow.com/questions/6674327/redirect-all-output-to-file-in-bash
# npm test -- test/example.test.js  > allout.txt 2>&1
all_log=$(npm test -- test/example.test.js 2>&1) 
TEST_RESULT=$?

# Check the exit code and print the appropriate message
if [ $TEST_RESULT -eq 0 ]; then
    echo "Tests succeeded"
else
    echo "Tests failed"
fi

echo 'print save log'
# we can check "PASS test/example.test.js" or "FAIL test/example.test.js"
echo ${all_log}

# Exit with the same code as Jest (optional but can be useful)
exit $TEST_RESULT
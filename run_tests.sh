#!/bin/bash

# jest output is usually in stderr, even if the test passes
# npm test -- test/example.test.js > stdout.txt 2> stderr.txt
# https://stackoverflow.com/questions/6674327/redirect-all-output-to-file-in-bash

currentDate=$(date +%Y-%m-%d-%H-%M-%S)
log_file=${currentDate}s.txt #"$currentDate-s.txt"
echo $currentDate
echo $log_file
test_file_name="test/example.test.js"
echo $test_file_name

# npm test -- test/example.test.js  > $currentDate 2>&1
# converting "all_log" to log file later might be  OK 
# but all_log already misse some format, e.g. breakline
# so store the log_file and all_log var initially
all_log=$(npm test -- $test_file_name 2>&1 | tee $log_file) 
EXIT_CODE=$?

STR='GNU/Linux is an operating system'
SUB="FAIL $log_file_name"
echo $SUB
# we can check "PASS test/example.test.js" or "FAIL test/example.test.js"
if grep -q "$SUB" <<< "$all_log"; 
then
    echo "It's fail case"
else
    echo "It's sucess case"
    # delete the file 
    rm $log_file
fi

echo 'print save log'
# echo ${all_log}

exit $EXIT_CODE
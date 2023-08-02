#!/bin/bash

# Declarate variable. Shorten for '/tmp/''.
tmp=/tmp/$$

function ERROR_EXIT () {
    echo "$1" >&2 
    cat $tmp-error
    rm -f $tmp-*
    exit 1
}

## start test

# Normal system
echo "test0-1: Normal"
./gcdiv.sh 66 99 > $tmp-result
echo "33" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test0-1" >> $tmp-error

echo "test0-2: Normal"
./gcdiv.sh 100 4 > $tmp-result
echo "4" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test0-2" >> $tmp-error

# Error system about number of args
echo "test1-1: Error-no-args"
./gcdiv.sh > $tmp-result
echo "Please input 2 natural number" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test1-1" >> $tmp-error

echo "test1-2: Error-1-args"
./gcdiv.sh 1 > $tmp-result
echo "Please input 2 natural number" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test1-2" >> $tmp-error

echo "test1-3: Error-1-args"
./gcdiv.sh 1 3 5 > $tmp-result
echo "Please input 2 natural number" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test1-3" >> $tmp-error

# Error system about negative number
echo "test2-1: Error-negative-number"
./gcdiv.sh -5 10 > $tmp-result
echo "-5 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test2-1" >> $tmp-error

echo "test2-2: Error-negative-number"
./gcdiv.sh 10 -20 > $tmp-result
echo "-20 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test2-2" >> $tmp-error

# Error system about not integir(includes string)
echo "test3-1: Error-not-integir"
./gcdiv.sh "aaa" 5 > $tmp-result
echo "aaa is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test3-1" >> $tmp-error

echo "test3-2: Error-not-integir"
./gcdiv.sh 5 3b9 > $tmp-result
echo "3b9 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test3-2" >> $tmp-error

# Error system about 0
echo "test4-1: Error-starting-from-0"
./gcdiv.sh 5 0010 > $tmp-result
echo "0010 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test4-1" >> $tmp-error

echo "test4-2: Error-0"
./gcdiv.sh 0 5 > $tmp-result
echo "0 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test4-2" >> $tmp-error

# Error system about decimal
echo "test5-1: Error-decimal"
./gcdiv.sh 3.14 5 > $tmp-result
echo "3.14 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test5-1" >> $tmp-error

echo "test5-2: Error-decimal"
./gcdiv.sh 5 6.77 > $tmp-result
echo "6.77 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test5-2" >> $tmp-error

# Error system about decimal
echo "test5-1: Error-decimal"
./gcdiv.sh 3.14 5 > $tmp-result
echo "3.14 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test5-1" >> $tmp-error

echo "test5-2: Error-decimal"
./gcdiv.sh 5 6.77 > $tmp-result
echo "6.77 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test5-2" >> $tmp-error

# Error system about above mix case(checking process order)
echo "test6-1: Error-mix-case"
./gcdiv.sh a -1 > $tmp-result
echo "a is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test6-1" >> $tmp-error

echo "test6-2: Error-mix-case"
./gcdiv.sh 001 abc > $tmp-result
echo "001 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test6-2" >> $tmp-error

echo "test6-3: Error-mix-case"
./gcdiv.sh 0.01 ,,, > $tmp-result
echo "0.01 is not a natural number." > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test6-3" >> $tmp-error

echo "test6-4: Error-mix-case"
./gcdiv.sh 0.01 > $tmp-result
echo "Please input 2 natural number" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test6-4" >> $tmp-error

echo "test6-5: Error-mix-case"
./gcdiv.sh 100 20 abc > $tmp-result
echo "Please input 2 natural number" > $tmp-ans
diff $tmp-result $tmp-ans || echo "error in test6-5" >> $tmp-error


# If an error occuerd on test, output the error.
if [ -f $tmp-error ]; then
    ERROR_EXIT
fi
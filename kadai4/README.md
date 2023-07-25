# Check great common divisor

## Environment
  - bash, zsh

## Description
  - gcdiv.sh 
    - A script that takes natural numbers as arguments and calculates the greatest common divisor by Euclidean algorithm.
  - gha_test.sh
    - CI test script for gcdiv.sh with GHA(GitHub Actions)

## How to use
  - gcdiv.sh
    ```
    # Calculate the greatest common divisor　with 2 natural numbers as arguments.
    $ ./gcdiv.sh 12 4
    3

    $ ./gcdiv.sh 5 12
    1
    
    # Negative and decimal numbers are rejected.
    $ ./gcdiv.sh 5 -12
    -12 is not a natural number.

    $ ./gcdiv.sh 5.452 12
    5.452 is not a natural number.

    # Reject even if it contains anything other than numbers.
    $ ./gcdiv.sh 5 3a    
    3a is not a natural number.

　　# Reject if there are not enough arguments(2 args).
    $ ./gcdiv.sh 5   
    Please input 2 natural number

    ```
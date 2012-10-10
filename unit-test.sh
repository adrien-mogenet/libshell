#!/bin/bash

source ./libshell.sh

assert_true "is_int 1" "1 is int"
assert_true "is_int 42" "42 is int"
assert_true "is_int 042" "042 is int"
assert_false "is_int foo" "foo is not int"
assert_false "is_int 1d" "1d is not int"

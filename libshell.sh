#!/bin/bash

## -----------------------------------------------------------------------------
## MISC (as usual)

# Check that $1 is an integer
is_int() {
  [ "$1" -eq "$1" ] > /dev/null 2>&1
  return $?
}

# Output list of available functions, etc.
doxyshell () {
  local fns=`typeset -f | awk '/ \(\) $/ && !/^main / {print $1}'`
  echo "Available functions:"
  for f in $fns; do
    echo " - ${f}"
  done
}


## -----------------------------------------------------------------------------
## ASSERTIONS

# Default assertion assert_equals
assert() {
  assert_equals "$1" "$2" "$3"
}

# Assertion that input condition is true
assert_true() {
  local condition=$1
  local msg=$2
  $condition >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "[OK] - ${msg}"
  else
    echo "[KO] - ${msg}"
  fi
}

# Assert that input condition is false
assert_false() {
  local condition=$1
  local msg=$2
  $condition >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "[KO] - ${msg}"
  else
    echo "[OK] - ${msg}"
  fi
}

# Assert that actual value is equals to the expected one
assert_equals() {
  local actual=$1
  local expected=$2
  local msg=$3
  if [ "$actual" = "$expected" ]; then
    echo "[OK] - ${msg}"
  else
    echo "[KO] - ${msg}"
  fi
}

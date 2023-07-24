#!/usr/bin/env bash

function test(){
  N=1000
  i=0
  while [ $i -lt $N ]; do
    ((i++))
    curl localhost:"$1" >/dev/null 2>&1
  done
}

function parallel() {
  pid=()
  for i in $(seq 1 "$1"); do
    "$2" "$3" &
    pid+=($!)
  done
  for p in "${pid[@]}"; do
    wait "$p"
  done
}
TIMEFORMAT=%R

RUNNERS=${RUNNERS:-30}
#
echo -e "RUNNERS #: $RUNNERS"
####################
#### PYTHON #####
####################
sleep 1
echo -n "#00: Test 'Python' Server (8000) with 1 runner, time = "
time test 8000
echo -n "#01: Test 'Python' Server (8000) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 8000
####################
#### Go #####
####################
sleep 1
echo -n "#10: Test 'Go' Server (8080) with 1 runner, time = "
time test 8080
echo -n "#11: Test 'Go' Server (8080) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 8080
####################
#### NodeJs #####
####################
sleep 1
echo -n "#20: Test 'NodeJs' Server (9000) with 1 runner, time = "
time test 9000
echo -n "#21: Test 'NodeJs' Server (9000) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 9000

unset TIMEFORMAT
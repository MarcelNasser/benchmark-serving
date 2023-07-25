#!/usr/bin/env bash

#Env
TIMEFORMAT=%R
COOLDOWN=${COOLDOWN:-3}
RUNNERS=${RUNNERS:-30}
REQUESTS=${REQUESTS:-500}
#

function test(){
  i=0
  sleep "$COOLDOWN"
  while [ $i -lt "$REQUESTS" ]; do
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


echo -e "RUNNERS #: $RUNNERS"
####################
#### PYTHON #####
####################
echo -n "#0: Test 'Python' Server (8000) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 8000
####################
#### Go #####
####################
echo -n "#1: Test 'Go' Server (8080) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 8080
####################
#### NodeJs #####
####################
echo -n "#2: Test 'NodeJs' Server (9000) with $RUNNERS runners, time = "
time parallel "$RUNNERS" test 9000

unset TIMEFORMAT
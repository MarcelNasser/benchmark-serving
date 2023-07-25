#!/usr/bin/env bash

#Env
TIMEFORMAT=%R
RUNNERS=${RUNNERS:-100}
REQUESTS=${REQUESTS:-100}
COOLDOWN=${COOLDOWN:-3}
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

ports=(8000 8001 8002 8003)
servers=(Python Fastapi Go NodeJs)

for i in $(seq 0 3); do
  echo -n "#$i: Test '${servers[$i]}' Server (${ports[$i]}) with $((RUNNERS*REQUESTS)) req, time = "
  time parallel "$RUNNERS" test ${ports[$i]}
done

unset TIMEFORMAT
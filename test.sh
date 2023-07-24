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
  n=$2
  for i in $(seq 1 $n); do
    test "$1" &
    pid+=($!)
  done
  for p in "${pid[@]}"; do
    #echo waiting .. $p
    wait "$p"
  done
}

echo "#0: Test 'Python' Server (8000)"
time test 8000
echo -e "\n"
echo "#1: Test 'Go' Server (8080)"
time test 8080
echo -e "\n"
echo "#2: Test 'Python' Server (8000) with 30 runners"
time parallel 8000 30
echo -e "\n"
echo "#3: Test 'Go' Server (8080) with 30 runners"
time parallel 8080 30

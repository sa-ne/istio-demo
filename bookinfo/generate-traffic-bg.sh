#!/bin/bash

for i in {1..10}
do
    ./generate-traffic.sh 2>&1 >/dev/null &
done

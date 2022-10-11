#!/bin/bash

cat /etc/os-release | grep PRETTY_NAME | sed -e 's/PRETTY_NAME=//g' | sed -e 's/\"//g'
hostname -I

term_handler() {
    kill -SIGTERM "$killpid"
    wait "$killpid" -f 2>/dev/null
    exit 143
}

trap 'kill ${!}; term_handler' SIGTERM
lsyncd /home/docker/lsyncd.conf
killpid="$!"

while true; do
    wait $killpid
    exit 0
done
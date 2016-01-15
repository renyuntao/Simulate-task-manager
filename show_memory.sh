#!/usr/bin/env bash

while true
do
	memory_usage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)",$3-$6-$7,$2,100*($3-$6-$7)/$2}')
	echo -en "$memory_usage    \r"
	sleep 1
done

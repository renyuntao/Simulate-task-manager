#!/usr/bin/env bash
# Date: 2016-03-08
# Function: Look over the Memory usage
# Maintainer: YtRen <rytubuntulinux@gmail.com>

real=''
h=''
while getopts "rh" opt
do
	case $opt in
		r)
			real='True'
			;;
		h)
			h='True'	
			;;
		\?)
			;;
	esac
done

if [ "$h" == "True" ]
then
	echo -e "\n\e[1mOptions:\e[0m\n"
	echo -e "    \e[1m-r:\e[0m Include Buffer and Cache when calculate Memory Usage"
	echo -e "        (Default is not include Buffer and Cache)\n"
	exit 1
fi

if [ "$real" == "True" ]
then
	free | egrep 'Mem' | awk '{print ($3)*100/$2 "%"}'
else
	free | egrep 'Mem' | awk '{print ($3-$6-$7)*100/$2 "%"}'
fi

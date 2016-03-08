#!/usr/bin/env bash
# Date: 2016-03-08
# Function: Look over the Memory usage
# Maintainer: YtRen <rytubuntulinux@gmail.com>

free | egrep 'Mem' | awk '{print ($3-$6-$7)*100/$2 "%"}'

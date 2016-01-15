#!/usr/bin/env bash

clear
PREV_TOTAL=0
PREV_IDLE=0
while true
do
  # 从文件`/proc/stat`获取CPU时间
  CPU=(`sed -n 's/^cpu\s//p' /proc/stat`)
  IDLE=${CPU[3]} # Just the idle CPU time.

  # 计算总的CPU时间
  TOTAL=0
  for VALUE in "${CPU[@]}"; do
	let "TOTAL=$TOTAL+$VALUE"
  done

  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"

  # 计算CPU利用率
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

  # 显示CPU的利用率
  echo -n "["
  for((i=0; i < $DIFF_USAGE; ++i))
  do
	echo -n "#"
  done
  left=$((100-$DIFF_USAGE))
  for((i=0; i < $left; ++i))
  do
	echo -n " "
  done
  echo -en "] CPU: $DIFF_USAGE%"

  # 更新PREV_TOTAL和PREV_IDLE
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"

  # 等待1秒
  sleep 1
  clear
done

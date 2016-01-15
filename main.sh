#!/usr/bin/env bash

# 杀死进程
function kill_process()
{
	PID_FILE="pid.txt"
	USER=`whoami`

	# 创建一个包含PID,进程名的文件
	ps -u $USER -o pid -o comm > $PID_FILE

	# 在每一行末尾添加` OFF`
	sed -i 's/$/ OFF/' $PID_FILE

	# 删除最后一行，即`ps`进程那一行
	sed -i '$d' $PID_FILE

	# 读文件
	i=0
	while read -r line 
	do
		len=`echo $line | wc -w`
		if [ $len == 3 ]
		then
			a[$i]=$line
			let '++i'
		fi
	done < $PID_FILE


	# 保存用户的选择
	pid=`whiptail --title "Kill The Process" --radiolist  "Make Your Choice:"  20 80 12 ${a[@]:1} 3>&1 1>&2 2>&3`


	# 杀死进程
	if [ ${#pid} != 0 ]
	then
		kill $pid
	fi

	# 删除文件
	rm $PID_FILE
}

# 显示进程
function show_process()
{
	FILE="process.txt"
	USER=`whoami`

	# 创建一个名为"$FILE"的文件，该文件中包含了各个进程名
	ps -u $USER -o comm > $FILE

	# 删除最后一行，即`ps`进程那一行
	sed -i '$ d' $FILE


	whiptail --textbox --scrolltext $FILE 20 80

	# 删除文件
	rm $FILE
}

# 显示应用程序
function show_application()
{
	FILE1="application.txt"
	USER=`whoami`

	# 创建一个名为"$FILE"的文件，该文件中包含了各个应用程序名
	ps -u $USER -o comm= | sort | uniq > $FILE

	# 删除`ps`应用程序那一行
	sed -i '/^ps$/ d' $FILE

	whiptail --textbox --scrolltext $FILE 20 80

	# 删除文件
	rm $FILE
}

# 杀死应用程序
function kill_application()
{
	FILE='application.txt'
	USER=`whoami`

	# 创建一个文件，其中包含了应用程序名
	ps -u $USER  -o comm= | sort | uniq > $FILE

	# 删除包含`ps`进程的那一行
	sed -i '/^ps$/ d' $FILE

	# 在每一行末尾加上` OFF`
	sed -i 's/$/ OFF/' $FILE

	# 读文件
	i=0
	while read -r line
	do
		len=`echo $line | wc -w`
		if [ $len == 2 ]
		then
			a[$i]=$line
			let '++i'
		fi
	done < $FILE

	# 保存用户的选择
	select=`whiptail --title "Kill The Application" --radiolist --noitem "Make Your Choice:"  20 80 12 ${a[@]} 3>&1 1>&2 2>&3`

	# 杀死应用程序
	pkill $select

	# 删除文件
	rm $FILE
}

# 显示CPU的利用率
function show_cpu_utilization()
{
	gnome-terminal -x "./cpu_utilization.sh"
}

# 显示内存使用情况
function show_memory()
{
	gnome-terminal -x ./show_memory.sh
}

# 显示菜单
function show_menu()
{
	while true
	do
		# 保存用户的选择
		select=`whiptail --title "Menu" --menu "Choice" 20 80 10 1 "Show current process" 2 "Kill the process" \
		3 "Show Current Application" 4 "Kill the application" 5 "Show CPU utilization" \
		6 "Show Memory Usage" 7 "Exit" 3>&1 1>&2 2>&3`

		# 根据用户的选择作出相应的动作
		case $select in
			"1")
				show_process
				;;
			"2")
				kill_process
				;;
			"3")
				show_application
				;;
			"4")
				kill_application
				;;
			"5")
				show_cpu_utilization
				;;
			"6")
				show_memory
				;;
			"7")
				echo "Exit"
				exit 1
				;;
			*)
				exit 1
				;;
		esac
	done
}

show_menu

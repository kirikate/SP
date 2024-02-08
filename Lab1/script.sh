#!/bin/bash

_COLUMNS=60
_ROWS=25
_SEED=1

function randomNumber(){
	(( _SEED = _SEED * 1103515245 + 12345 ))
	local res=$(( (_SEED / 65536) % 32768 ))
	return $res
}

# value letter indent x y
function smth(){
	local val=$1; local letter=$2; 
	local indent=$3; local x=$4; local y=$5;
	case $val in
	1)
		tput cup $((y+1+indent)) $((x+12))
		printf "^"
		tput cup $((y+2+indent)) $((x+12))
		printf "$letter"
	;;
	2)
		tput cup $((y+2)) $((x+14-indent))
		printf ">"
		tput cup $((y+2)) $((x+14-indent-1))
		printf "$letter"
	;;
	3)
		tput cup $((y+4)) $((x+14-indent))
		printf ">"
		tput cup $((y+4)) $((x+14-indent-1))
		printf "$letter"
	;;
	4)
		tput cup $((y+6)) $((x+14-indent))
		printf ">"
		tput cup $((y+6)) $((x+14-indent-1))
		printf "$letter"
	;;
	5)
		tput cup $((y+7 - indent)) $((x+12))
		printf "V"
		tput cup $((y+7-indent-1)) $((x+12))
		printf "$letter"
	;;
	6)
		tput cup $((y+7 - indent)) $((x+8))
		printf "V"
		tput cup $((y+7-indent-1)) $((x+8))
		printf "$letter"
	;;
	7)
		tput cup $((y+7 - indent)) $((x+4))
		printf "V"
		tput cup $((y+7-indent-1)) $((x+4))
		printf "$letter"
	;;
	8)
		tput cup $((y+6)) $((x+2+indent))
		printf "<"
		tput cup $((y+6)) $((x+2+indent+1))
		printf "$letter"
	;;
	9)
		tput cup $((y+4)) $((x+2+indent))
		printf "<"
		tput cup $((y+4)) $((x+2+indent+1))
		printf "$letter"
	;;
	10)
		tput cup $((y+2)) $((x+3+indent))
		printf "<"
		tput cup $((y+2)) $((x+3+indent+1))
		printf "$letter"
	;;
	11)
		tput cup $((y+1+indent)) $((x+5))
		printf "^"
		tput cup $((y+2+indent)) $((x+5))
		printf "$letter"

	;;
	0)
		tput cup $((y+1+indent)) $((x+9))
		printf "^"
		tput cup $((y+2+indent)) $((x+9))
		printf "$letter"
		
	;;
	esac

	# printf "$letter"
	
	tput cup 0 0
}

# x y h m s
function printArrows(){
	local x=$1; local y=$2; 
	local h=$[10#$3]; 
	local m=$[10#$4];
	local s=$[10#$5]
	
	smth $(((m - m%5) / 5)) "m" 1 $x $y
	smth $(((s - s%5) / 5)) "s" 1 $x $y
	smth $((h%12)) "h" 1 $x $y
		
}

function printClocks(){
	randomNumber 
	local rand=$?
	# echo " random result is     $rand     "
	local x=$((rand % (_COLUMNS - 16)))
	
	randomNumber
	local rand2=$?
	local y=$((rand2 % (_ROWS - 8)))
	# local x=15
	# local y=8
	tput cup $y $x
	printf "#################"
	
	tput cup $((y+1)) $x
	printf "#   11  12  1   #"
	
	tput cup $((y+2)) $x
	printf "# 10          2 #"
	
	tput cup $((y+3)) $x
	printf "#               #"
	
	tput cup $((y+4)) $x
	printf "# 9     0     3 #"
	
	tput cup $((y+5)) $x
	printf "#               #"
	
	tput cup $((y+6)) $x
	printf "# 8           4 #"
	
	tput cup $((y+7)) $x
	printf "#   7   6   5   #"
	
	tput cup $((y+8)) $x
	printf "#################"
	
	tput cup 0 0
	
	printArrows $x $y $1 $2 $3
}

function printBorder(){
	for ((i=0; i <$_COLUMNS; ++i))
	do
		printf "#"
	done
	
	printf "\n"
	
	for ((i=1; i < $_ROWS; ++i))
	do
		printf "#"
		for ((j=0; j<$_COLUMNS-2;++j))
		do
			printf " "
		done
		printf "#\n"
	done
	
	for ((i=0; i <$_COLUMNS; ++i))
	do
		printf "#"
	done
}

function printTime(){
	tput cup 1 0
	printf "$1 $2 $3"
	printClocks $1 $2 $3
}

_SEED=$( date "+%s" )
while true;do
	clear
	tput cup 0  0
	
	printBorder
	
	hour=$(date "+%H")
	minute=$(date "+%M")
	second=$(date "+%S")
	
	printTime $hour $minute $second
	tput cup $_ROWS 0
	sleep 1
done
#01234567890123456
 #################0
 #   11  12  1   #1
 # 10          2 #2
 #               #3
 # 9     0     3 #4
 #               #5
 # 8           4 #6
 #   7   6   5   #7
 #################8

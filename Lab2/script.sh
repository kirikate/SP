#!/bin/bash

function getsize(){
	# local tmpfile="$(($RANDOM+0))_$(($RANDOM+0)).txt"
	local res=$(du "$1")

	if [[ "$res" =~ ([0-9]+) ]]; 
	then
    	return ${BASH_REMATCH[1]}
	else
		echo "unable to parse string $res"
		exit 1
	fi

}

function sizeComparator(){
	local testA=0
	local testB=0
	
	getsize $1
	local size1=$?
	getsize $2
	local size2=$?
	echo "size1 = $size1 ; size2 = $size2"
	
	if ((size1 == size2))
	then
		# echo "equal length"
		return 1
	fi
	
	(( size1 < size2 )) || testA=1
	[ "$3" = "desc" ] || testB=1
	
	if [ "$testA" -ne "$testB" ]
	then
		return 1
	else
		return 0
	fi
}

function getdate(){
	local res=$(stat "$1")
	# echo "res = $res arg=$1"
	
	if [[ "$res" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}) ]];
	then
		retval=${BASH_REMATCH[1]}
	else
		echo "can't parse date of $1"
	fi
}

function dateComparator(){
	local testA=0
	local testB=0
	
	getdate $1
	local date1=$retval
	getdate $2
	local date2=$retval
	
	if [ "$date1" = "$date2" ];
	then
		return 1
	fi
	
	[[ "$date1" < "$date2" ]] || testA=1
	[ "$3" = "desc" ] || testB=1
	
	if [ "$testA" -ne "$testB" ]
	then
		return 1
	else
		return 0
	fi
}

function alphabetComparator(){
	local testA=0
	local testB=0
	[[ "$1" < "$2" ]] || testA=1
	[ "$3" = "desc" ] || testB=1
	
	if  [ "$testA" -ne "$testB" ]
	then
		return 1
	else
		return 0
	fi
}

function namelengthComparator(){
	local testA=0
	local testB=0
	echo "length of $1 = ${#1} length of $2 = ${#2}"
	if ((${#1} == ${#2}))
	then
		# echo "equal length"
		return 1
	fi
	
	(( ${#1} < ${#2} )) || testA=1
	[ "$3" = "desc" ] || testB=1
	
	if [ "$testA" -ne "$testB" ]
	then
		return 1
	else
		return 0
	fi
}

# 1 - comparator
# 2 - desc/asc

function random(){
	local arraysize=${#filesarr[@]}
	local randcount
	local i
	((randcount = arraysize * 2 ))
	echo "count = $randcount"
	for ((i=0; i < randcount; ++i))
	do
		local i1
		((i1=$RANDOM % arraysize))
		local i2
		((i2=$RANDOM % arraysize))
		# echo "i1= $i1 i2=$i2"
		local tmp=${filesarr[i1]}
		filesarr[$i1]=${filesarr[i2]}
		filesarr[$i2]=$tmp
	done
}

# comparator asc/desc
function mysort(){
	local comparator=$1
	local i
	local j
	for ((i=0; i < ${#filesarr[@]}; ++i))
	do
		for ((j=0; j < ${#filesarr[@]} - i - 1; ++j ))
		do
			# echo "i = $i j= $j"
			if  $comparator ${filesarr[j]} ${filesarr[j+1]} $2
			then
				# echo "swap"
				local tmp=${filesarr[j]}
				filesarr[$j]=${filesarr[j+1]}
				filesarr[((j+1))]=$tmp
			fi
		done
	done
}

function undoNumbers(){
	for ((i = 0; i < ${#filesarr[@]}; ++i))
	do
		local filename=${filesarr[i]}
		if [[ $filename =~ ^[0-9]{4}\.(.*) ]];
		then
			# echo "filename without number ${BASH_REMATCH[1]}"
			mv "$filename" "${BASH_REMATCH[1]}"
		fi
	done
}

function getFiles(){
	local tmpfile="$(($RANDOM+0))_$(($RANDOM+0)).txt"

	$(ls >> $tmpfile)
	
	local tmpfile2="$(($RANDOM+0))_$(($RANDOM+0)).txt"
	
	grep ".*\..*" $tmpfile >> $tmpfile2
	rm $tmpfile
	
	local i=0

	while read line;do
		if [ $line = $tmpfile ] || [ $line = $tmpfile2 ] || [ $line = $scriptname ]
		then
			continue
		fi
		filesarr[$i]=$line
		# echo "DEBUG i = $i line = $line filesarr[i] = ${filesarr[i]}"
		((i=i+1))
		# echo ${filesarr[*]}
	done < "$tmpfile2"
	rm "$tmpfile2"
}

function showHelp(){
	echo "-h -- help. Nothing more will be done"
	echo "-d -- sort by datetime of last change"
	echo "-s -- sort by size of file"
	echo "-a -- sort by alphabet order"
	echo "-l -- sort by namelength"
	echo "-u -- undo numbers. Nothing more will be done"
	echo "-p -- path to directory. If there is no path script will executes in current directory"
	echo "bash script.sh -p 'path' [-d (desc/asc)]"
}
scriptname="$0"

declare -a filesarr

declare -a sortstack

i=0

while getopts ':hrua:d:l:s:p:' opt; do
	case "$opt" in
	a)
		if [ $OPTARG = "desc" ] || [ $OPTARG = "asc" ]
		then
			sortstack[$i]="mysort alphabetComparator $OPTARG"
			((i=i+1))
		else
			exit 1
		fi
	;;
	d)
		if [ $OPTARG = "desc" ] || [ $OPTARG = "asc" ]
		then
			sortstack[$i]="mysort dateComparator $OPTARG"
			((i=i+1))
		else
			echo "error in arg of $opt . It can't be $OPTARG"
			exit 1
		fi
	;;
	l)
		if [ $OPTARG = "desc" ] || [ $OPTARG = "asc" ]
		then
			sortstack[$i]="mysort namelengthComparator $OPTARG"
			((i=i+1))
		else
			echo "error in arg of $opt . It can't be $OPTARG"
			exit 1
		fi
	;;
	s)
		if [ $OPTARG = "desc" ] || [ $OPTARG = "asc" ]
		then
			sortstack[$i]="mysort sizeComparator $OPTARG"
			((i=i+1))
		else
			echo "error in arg of $opt . It can't be $OPTARG"
			exit 1
		fi
	;;
	r)
		# echo "in random"
		sortstack[$i]="random"
		((i=i+1))
	;;
	h)
		showHelp
		exit 0		
	;;
	u)
		# echo " in undoNumbers case"
		getFiles
		undoNumbers
		exit 0
	;;
	p)
		cd "$OPTARG"
		if (($? != 0));
		then
			echo "Error in path $OPTARG"
			exit 1
		fi
	;;
	:)
		echo -e "Option requires an argument desc/asc"
		exit 1
	;;
	?)
		echo -e "There is no such option. Use -h to get help"
		exit 1
	;;
  esac
  echo "option"
done

getFiles
undoNumbers
for file in ${filesarr[@]}
do
	echo "file $file"
done

for ((i=i-1; i >= 0; --i))
do
	eval "${sortstack[i]}"
done

for file in ${filesarr[@]}
do
	getdate "$file"
	getsize "$file"
	echo "size=$? date = $retval file $file "
done

for ((i=0; i < ${#filesarr[@]}; ++i))
do
	declare number
	file=${filesarr[i]}
	if ((i <= 9));
	then
		number=000$i
	elif ((i <= 99))
	then
		number=00$i
	elif ((i <= 999))
	then
		number=0$i
	else
		number=$i
	fi
	mv $file "$number.$file"
done



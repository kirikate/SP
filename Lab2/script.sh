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
	testA=0
	testB=0
	
	getsize $1
	size1=$?
	getsize $2
	size2=$?
		
}

function alphabetComparator(){
	testA=0
	testB=0
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
	testA=0
	testB=0
	echo "length of $1 = ${#1} length of $2 = ${#2}"
	if ((${#1} == ${#2}))
	then
		echo "equal length"
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

function mysort(){
	local comparator=$1
	for ((i=0; i < ${#filesarr[@]}; ++i))
	do
		for ((j=0; j < ${#filesarr[@]} - i - 1; ++j ))
		do
			echo "i = $i j= $j"
			if  $comparator ${filesarr[j]} ${filesarr[j+1]} $2
			then
				echo "swap"
				local tmp=${filesarr[j]}
				filesarr[$j]=${filesarr[j+1]}
				filesarr[((j+1))]=$tmp
			fi
		done
	done
}

function getFiles(){
	local tmpfile="$(($RANDOM+0))_$(($RANDOM+0)).txt"

	$(ls >> $tmpfile)
	
	local tmpfile2="$(($RANDOM+0))_$(($RANDOM+0)).txt"
	
	grep ".*\..*" $tmpfile >> $tmpfile2
	rm $tmpfile
	
	i=0

	while read line;do
		if [ $line = $tmpfile ] || [ $line = $tmpfile2 ]
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

declare -a filesarr
getFiles
for file in ${filesarr[@]}
do
	echo "file $file"
done

mysort namelengthComparator asc
getsize script.sh
echo "res = $?"

strname="ph7go04325r"
if [[ $strname =~ ([0-9]+)r ]]; then
	echo "success ${BASH_REMATCH[1]}"
    strresult=${BASH_REMATCH[1]}
else
    echo "unable to parse string $strname"
fi


for file in ${filesarr[@]}
do
	echo "file $file"
done


while getopts ':a:d:l:s:h' opt; do
	case "$opt" in
	a)
		if [ $OPTARG = "desc" ]
		then
			echo "a in desc"
		elif [ $OPTARG = "asc" ]
		then
			echo "a in asc"
		else
			echo "error"
			exit 1
		fi
	;;
	d)
		if [ $OPTARG = "desc" ]
		then
			echo "d in desc"
		elif [ $OPTARG = "asc" ]
		then
			echo "d in asc"
		else
			echo "error"
			exit 1
		fi
	;;
	l)
		if [ $OPTARG = "desc" ]
		then
			echo "l in desc"
		elif [ $OPTARG = "asc" ]
		then
			echo "l in asc"
		else
			echo "error"
			exit 1
		fi
	;;
	s)
		if [ $OPTARG = "desc" ]
		then
			echo "s in desc"
		elif [ $OPTARG = "asc" ]
		then
			echo "s in asc"
		else
			echo "error"
			exit 1
		fi
	;;
	h)
		echo "help text"
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
done

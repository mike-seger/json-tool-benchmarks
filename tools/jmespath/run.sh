#!/bin/bash
##!/usr/bin/env bash

#set -x 
timecommand=$(which gtime)
[ -x "$timecommand" ] || timecommand=/usr/bin/time
TIME='timeout 10 '$timecommand' -f %U'


#echo -n '{"name": "'$b'", "n": '$n', "time": {'
tools=( "jmes-java" "jmes-go", "jmes-rust" )
tool=jp

cat tools/jmespath/tests.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv' | \
while read line; do
	IFS=$'\t'
	cols=($line)
	[[ "$line" == *expression* ]] && pointers=($line) && continue
	for i in {0..2}; do printf -v "${pointers[$i]}" "%s" "${cols[$i]}"; done
	[[ "$name" == \#* ]] && continue
	echo "$name ($n) -> $expression" >&2

	i=1
#	echo -n '"'$tool'": ['
		echo -n "{\"name\": \"$name\", \"n\": $n, \"time\": {"
	first=1
	for tool in "${tools[@]}"; do
		[ $first -ne 1 ] && echo -n ', '
		first=0
		echo -n "\"$tool\": ["
	#	echo "$name: cat data/people.json | jp '$expression'"
	#	echo "cat data/people.json | timeout 10 $timecommand -f %U "$tool" \"$expression\" $n" >&2

		if [ "$tool" == "jp" ] ; then		
			t=$(cat data/people.json | timeout 10 $timecommand -f %U $tool "$expression" $n 2>&1 > /dev/null)
		else 
			t=$(cat data/people.json | bin/$tool "$expression" $n | tail -1)
		fi
#		[ $? != 0 ] && break # error from call
#		[ -z "$t" ] && break # terminate on timeout
		#cat data/people.json | jp "$expression" | tr -d " \n" 2>/dev/null | cut -b 1-200
	#	echo "Time: $t"
		echo -n $t
		
		echo -n ']'
	done
	
	echo '}}'
done

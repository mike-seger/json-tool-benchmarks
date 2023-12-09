#!/bin/bash

timecommand=$(which gtime)
[ -x "$timecommand" ] || timecommand=/usr/bin/time
TIME='timeout 10 '$timecommand' -f %U'

tools=( "jp-java" "jp-graal" "jp-go" "jp-rust" "jp-js" )
tool=jp

cat tools/jmespath/tests-compliance.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv' | \
while read line; do
	IFS=$'\t'
	cols=($line)
	[[ "$line" == *expression* ]] && pointers=($line) && continue
	for i in {0..3}; do printf -v "${pointers[$i]}" "%s" "${cols[$i]}"; done
	[[ "$name" == \#* ]] && continue
	echo "$name ($n) -> $expression < $input" >&2
#continue
	i=1
	echo -n "{\"name\": \"$name\", \"n\": $n, \"time\": {"
	first=1
	for tool in "${tools[@]}"; do
		[ $first -ne 1 ] && echo -n ', '
		first=0
		echo -n "\"$tool\": ["

		if [ "$tool" == "jp" ] ; then		
			t=$(echo "$input" | timeout 10 $timecommand -f %U $tool "$expression" $n 2>&1 > /dev/null)
		else 
			t=$(echo "$input" | bin/$tool "$expression" $n | tail -1)
		fi
		echo -n $t
		
		echo -n ']'
	done
	
	echo '}}'
done

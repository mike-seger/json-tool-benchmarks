#!/usr/bin/env bash

timecommand=$(which gtime)
[ -x "$timecommand" ] || timecommand=/usr/bin/time
TIME='timeout 10 '$timecommand' -f %U'

tools=( "jp-java" "jp-graal" "jp-go" "jp-rust" "jp-js" )
tool=jp
prevname=""

declare -A toolsum
for tool in "${tools[@]}"; do
	toolsum["$tool"]=0
done

function showSum() {
	local prevname=$1
	local name=$2
	local first=1
	if [[ "$prevname" != "" && "$prevname" != "$name" ]] ; then
		echo -n "{\"name\": \"$prevname\", \"n\": $n, \"time\": {"
		for tool in "${tools[@]}"; do
			[ $first -ne 1 ] && echo -n ', '
			first=0
			echo -n "\"$tool\": ["
			echo -n ${toolsum["$tool"]}			
			echo -n ']'
		done		
		echo '}}'
		
		for tool in "${tools[@]}"; do
			toolsum["$tool"]=0
		done
	fi
}

first=1
while read line; do
	IFS=$'\t'
#	cols=($line)
	if [[ $first == 1 ]]; then
		first=0
		pointers=($line)
		continue
	fi
	
	for i in {0..3}; do 
		value=$(echo "$line" | cut -f$((i+1)))
#echo "Key: "${pointers[$i]}" " >&2
		printf -v "${pointers[$i]}" "%s" "$value"; 
	done

#	[[ "$name" != syntax ]] && continue

#expression=$(echo "$expression"|sed -e "s/\*/\\*/g;"|tr -d '`')
#expression=$(echo "$expression"|sed -e "s/\*/\\*/g;"|tr -d '`')
	[[ "$name" == \#* ]] && continue
	showSum "$prevname" "$name"

	echo "$name ($n) -> $expression" >&2
	for tool in "${tools[@]}"; do
		output=$(echo "$input" | bin/$tool $(echo "$expression") $n  2>/dev/null)
		if [ $? != 0 ]; then
			continue
		fi
		t=$(echo "$output" | tail -1)
		current=${toolsum["$tool"]}
#echo "$current" >&2
#continue
#echo "$current + 0$t"
		toolsum["$tool"]=$(echo "$current + 0$t" | bc)
	done
	prevname=$name
#	echo "prevname $prevname"
done <<<$(cat tools/jmespath/tests-compliance.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv')

#echo Hello "$prevname" ""
showSum "$prevname" ""

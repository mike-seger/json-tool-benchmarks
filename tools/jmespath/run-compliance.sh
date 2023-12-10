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
		echo "" >&2
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
		echo "" >&2
	fi
}

lineno=0 
while read line; do
	#IFS=$'\t'
	lineno=$(($lineno + 1))
	if [[ $lineno == 1 ]]; then
		pointers=($line)
		continue
	fi
	
	for i in {0..3}; do 
		value=$(echo "$line" | cut -f$((i+1)))
		printf -v "${pointers[$i]}" "%s" "$value"; 
	done

	showSum "$prevname" "$name"
	prevname=$name
	[[ "$name" == \#* ]] && continue
#	[[ "$name" != "syntax" ]] && continue

#	echo "$name ($n) -> $expression" >&2
	echo -n . >&2
	for tool in "${tools[@]}"; do
		output=$(echo "$input" | bin/$tool $(echo "$expression") $n  2>/dev/null)
		if [ $? != 0 ]; then
			echo >&2
			echo "Failed ($tool) (line $lineno): $name ($n) -> $expression" >&2
			break
		fi
		t=$(echo "$output" | tail -1)
		current=${toolsum["$tool"]}
		toolsum["$tool"]=$(echo "$current + 0$t" | bc)
	done
done <<<$(cat tools/jmespath/tests-compliance.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv')

showSum "$prevname" ""

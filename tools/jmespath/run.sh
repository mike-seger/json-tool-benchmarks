#!/usr/bin/env bash

cat tools/jmespath/tests.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv' | \
while read line; do
	expression="${line%%$'\t'*}"
	name="${line##*$'\t'}"
	[[ "expression" == "$expression" || "$name" == \#* ]] && continue 
	echo "$name"
#	echo "$name: cat data/people.json | jp '$expression'"
	cat data/people.json | jp "$expression" | tr -d " \n" 2>/dev/null | cut -b 1-200
	echo
done

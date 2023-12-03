#!/usr/bin/env bash

cat tools/jmespath/tests.json |jq -r '
	(map(keys) | add | unique) as $cols | map(. as $row | $cols | 
	map($row[.])) as $rows | $cols, $rows[] | @tsv' | \
while read line; do
	expression="${line%%$'\t'*}"
	name="${line##*$'\t'}"
	[[ "expression" == "$expression" || "$name" == \#* ]] && continue 
	echo "$name: cat data/people.json | jp '$expression'"
	cat data/people.json | jp "$expression"
done

exit 0

cat data/people.json | jp "people[?lastName=='Smith'].age"
cat data/people.json | jp "people[?lastName=='Smith']|sort_by(@, &age)[].age"
cat data/people.json | jp "people|reverse(@)|length(@)"


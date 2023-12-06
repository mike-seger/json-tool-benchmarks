#!/usr/bin/env bash

#cat bench.json | sed -e "s/{, /{/g" >b && mv b bench.json
bold=$(tput bold)
normal=$(tput sgr0)

#file=bench.json
#[ "$1" != "" ] && file=$1 

(printf "Benchmark\tn\tjmes-java\tjmes-go\tjmes-rust\tjmes-js\n"
cat | jq -rs '.[] | "|`\(.name)`|\(.n)|" + ([.time[] | min |
	(.*1000|round)? // "N/A"] | min as $total_min | map(if . ==
	$total_min then "**\(.)**" else "\(.)" end) | join("|"))' | \
	tr -d '`'|sed -e "s/|//;s/\*\*/${bold}/;s/\*\*/${normal}/"|tr "|" "\t" | tr -s "\t" | tr -d " *"
) | column -t

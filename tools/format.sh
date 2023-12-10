#!/usr/bin/env bash

(printf "Benchmark\tn\tjp-java\tjp-graal\tjp-go\tjp-rust\tjp-js\n"
cat | jq -rs '.[] | "|`\(.name)`|\(.n)|" + ([.time[] | min |
	(.*1000|round)? // "N/A"] | min as $total_min | map(if . ==
	$total_min then "\(.) *" else "\(.)" end) | join("|"))' | \
	tr -d '\`'|\
	tr "|" "\t" | tr -s "\t" |\
	sed -e 's/^[ \t]*//'
) | tee /tmp/2 | column -t -s $'\t'

cat /tmp/2

cat /tmp/2 |sed -e 's/^[ \t]*//;s/\t/|\t/g;s/.*/&|/;s/Bench.*/&\n-->&/' | \
        column -t -C 1 -R 2,3,4,5,6,7 | grep "[A-z]" | \
        sed '/-->/{s/[^|]/-/g;};
        	s/.*/|&/;s/-|/:|/g;
        	s/|/ | /g;s/`//;s/`$//;
        	s/\([:-]\)`|/-\1|/g;
        	s/`-/--/g;s/-:|/--|/;
        	s/: |/--|/;s/| -/|--/g;s/: |/-:|/g;
        	s/ *\*/ */g;s/-*$//;
        	'
        	#|\
        #sed -E 's/( *)\*+([0-9]*)\**( *)/\$\${\\color[RGB]{121,189,66}\1\2\3}$$/g;'

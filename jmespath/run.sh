#!/usr/bin/env bash

cat data/people.json | jp "people[?lastName=='Smith']|sort_by(@, &age)[].age"
cat data/people.json | jp "people[?lastName=='Smith']|sort_by(@, &age)[].age|reverse(@)"


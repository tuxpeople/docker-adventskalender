#!/bin/bash

if [ "`date +%m%d`" -lt "1201" ]; then echo "Es ist noch nicht Advent."; exit; fi
if [ "`date +%m%d`" -gt "1224" ]; then echo "Es ist nicht mehr Advent"; exit; fi

LINE=$(sed -n `date +%d`p /zitate.txt)

SAY=$(echo ${LINE} | cut -d';' -f1)
PERSON=$(echo ${LINE} | cut -d';' -f2)

RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
NC='\033[0m' # No Color
printf "${RED}TÜRCHEN $(date +%-d):\n\n${GREEN}${SAY}\n${LGREEN}${PERSON}${NC}\n\n"
echo -e "\u2764, dein Dockeradventskalender"

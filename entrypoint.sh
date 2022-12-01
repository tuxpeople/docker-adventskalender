#!/bin/bash
function box_out()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 3
  echo " -${b//?/-}-
| ${b//?/ } |"
  for l in "${s[@]}"; do
    printf '| %s%*s%s |\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
  done
  echo "| ${b//?/ } |
 -${b//?/-}-"
  tput sgr 0
}

export TERM='xterm-256color'

if [ "`date +%m%d`" -lt "1201" ]; then echo "Es ist noch nicht Advent."; exit; fi
if [ "`date +%m%d`" -gt "1224" ]; then echo "Es ist nicht mehr Advent."; exit; fi
LINE=$(sed -n `date +%d`p tipps.txt)

RED='\033[1;31m'
NC='\033[0m' # No Color

echo " "
printf "${RED}TÜRCHEN $(date +%-d)${NC}\n\n"
box_out "$(echo ${LINE} | cut -d'Q' -f1)" " " "$(echo ${LINE} | cut -d'Q' -f2)"
cat giraffe.txt
echo " "
echo " "
echo " "
echo -e "\u2764, dein Kubernetes-Adventskalender"

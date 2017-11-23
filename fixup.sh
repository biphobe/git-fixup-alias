#!/bin/bash
COMMITS=$(git log --oneline -9)

function fix { 
  COMMIT=$(echo "$COMMITS" | sed -n "$1"p)
  HASH=$(echo $COMMIT | cut -d ' ' -f 1)

  printf "\n\n"

  git add .;
  git commit -a --fixup=$HASH

  EDITOR=true git rebase -i --autosquash HEAD~4
}

printf "Pick commit to fix:\n\n"

while ((i++)); read -r line
do
  echo $i. $line;
done <<< "$COMMITS"

printf "\n"

read -p "Well?" -n 1 -r
case $REPLY in
  *) fix $REPLY;;
esac


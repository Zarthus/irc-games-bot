#!/bin/bash
# Copy a new file for the docs to the gh-pages branch by executing this script.
# Usage: ./mkdocs.sh --name="name"

for arg in $@; do
  if [[ $arg == "--no-prompt" ]]; then
    no_prompt="true"
  fi

  if [[ $arg == "--silent" ]]; then
    silent=$(($silent + 1))
  fi
  
  if [[ $arg == --name=* ]]; then
    DOCNAME=$(echo $arg | sed -E 's/.*=([a-zA-Z0-9]+)$/\1/')
  fi
done 

if [[ $DOCNAME == "" ]]; then
  echo "Please insert the name of the file (no file extension, case sensitive):"
  read DOCNAME
fi

CONST_URL="https://raw.githubusercontent.com/Zarthus/irc-games-bot/master/docs/$DOCNAME.md" 

mkdir -p docs/$DOCNAME
cat _copy/docs.html | sed -E "s/%title%/$DOCNAME/" | sed -E "s/%doctitle%/$DOCNAME/" > docs/$DOCNAME/index.html

if [[ $silent -eq 0 ]]; then
  echo "Generated link between docs/$DOCNAME/index.html and _includes/pages/docs/$DOCNAME"
fi

if [[ $silent -eq 0 ]]; then
  echo "Getting documentation content from the master branch."
fi

if [[ -e _includes/pages/docs/$DOCNAME.md ]]; then
  if [[ $no_prompt == "true" ]]; then
    OVERWRITE=1
  else
    echo "File already exists. Do you want to overwrite? [Y/n]"
    read OVERWRITE
    OVERWRITE=$(echo $OVERWRITE | grep -E '[yY]' | wc -l)
  fi
  
  if [[ $OVERWRITE -eq 1 ]]; then
    if [[ $silent -eq 0 ]]; then
      echo "Overwriting document: $DOCNAME."
    fi
    
    curl -s $CONST_URL > _includes/pages/docs/$DOCNAME.md
  else
    if [[ $silent -eq 0 ]]; then
      echo "Not overwriting document: $DOCNAME."
    fi
  fi
else
    curl -s $CONST_URL > _includes/pages/docs/$DOCNAME.md
fi  

if [[ $silent < 2 ]]; then
  echo "New documentation entry for $DOCNAME has been generated."
fi
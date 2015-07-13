#!/bin/bash
# Syncronize known docs (by mkdocs.sh) with the master branch on github.
# Usage: ./syncdocs.sh

CONTENT=""

for file in _includes/pages/docs/*.md; do
  FILE_NAME=$(echo $file | sed -E 's/.*\/([a-zA-Z0-9]+)\.md$/\1/')
  FILE_NAME_TITLE="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0:1})${FILE_NAME:1}"
  echo "Indexing $FILE_NAME_TITLE"
  CONTENT="$CONTENT[$FILE_NAME_TITLE](/docs/$FILE_NAME/)  \n"
done

echo -e "$CONTENT" > _includes/pages/docs/index.md

#!/bin/bash
# Syncronize known docs (by mkdocs.sh) with the master branch on github.
# Usage: ./syncdocs.sh

for file in _includes/pages/docs/*.md; do
  FILE_NAME=$(echo $file | sed -E 's/.*\/([a-zA-Z0-9\-]+)\.md$/\1/')
  ./mkdocs.sh --name="$FILE_NAME" --no-prompt --silent
done

echo ""
./indexdocs.sh

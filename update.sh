#!/bin/bash
# Script to update current docs, indexes, and push to github.

SYNC=`./syncdocs.sh`
SYNC_ERR_CODE=$?

if [[ $SYNC_ERR_CODE -ne 0 ]]; then
  echo "$SYNC"
  echo "Cannot commit changes. Error Code: $SYNC_ERR_CODE"
  exit 1
fi

BRANCH=$(git branch | head -1)

if [[ $BRANCH == "* gh-pages" ]]; then
  git add --all
  git commit -m "Automatically synchronized documentation with master." -m "$(echo "$SYNC")" --all
  git push
else
  echo "Current git branch is not gh-pages."
  echo $BRANCH
  exit 1
fi
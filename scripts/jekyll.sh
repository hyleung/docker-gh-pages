#!/bin/bash

case $1 in
  serve)
    echo "Starting Jekyll..."
    bundle install
    bundle exec jekyll serve
    ;;
  package)
    echo "Starting Jekyll..."
    BASE_PATH="$2"
    CUT_DIR=$(echo $BASE_PATH | awk -F/ '{for(j=1;j<=NF;j++) if (length($j)>0) print $j;}' | wc -l)
    bundle install
    bundle exec jekyll serve --detach
    EXPORT_DIR="${EXPORT_DIR:-/gh-pages/export}"
    echo "Exporting site...$BASE_PATH (cut-dirs=$CUT_DIR)"
    wget -q --convert-links -P "$EXPORT_DIR" -nH --cut-dirs=$CUT_DIR  -r "http://0.0.0.0:4000/$BASE_PATH"
    ;;
esac

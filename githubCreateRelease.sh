#!/bin/bash

function release {
    repo=$1
    semver=$2

    echo "Releasing $1 with version $2 as user $GITHUB_USER"

    curl \
        -X POST \
        -u $GITHUB_USER:$GITHUB_TOKEN \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/repos/ring-face/$1/releases \
        -d "{\"tag_name\":\"$2\"}"
}

if [ -z ${1+x} ]
  then
  echo "Please define semver to release. eg: release.sh 1.0.1"
  exit 1
  else

  echo "tagging master with release '$1'"
  release 'ringface-gui' $1
  release 'ringface-classifier' $1
  release 'ringface-connector' $1
  release 'ringface' $1

fi
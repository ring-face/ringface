#!/bin/bash

if [ -z ${1+x} ]
  then
  echo "Please define semver to release. eg: release.sh 1.0.1"
  exit 1
  else
  echo "building versions '$1'"
  ../ringface-gui/dockerImagesBuild.sh $1
  ../ringface-classifier/dockerImageBuild.sh $1
  ../ringface-connector/dockerImagesBuild.sh $1

  echo "replacing the .env to '$1'"
  sed -i '' '/VERSION/d' ./.env
  echo "VERSION=$1" >> ./.env
fi
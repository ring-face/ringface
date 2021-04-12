#!/bin/bash


if [ -z ${1+x} ]
  then
  echo "Please define semver to release. eg: release.sh 1.0.1"
  exit 1
  else

  ./dockerBuildImages.sh $1
  git commit -a -m "release $1"
  git push

  ./dockerPushImages.sh $1

  ./githubCreateRelease.sh $1

fi
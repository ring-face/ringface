#!/bin/bash


if [ -z ${1+x} ]
  then
  echo "Please define semver to release. eg: release.sh 1.0.1"
  exit 1
  else

  ./dockerBuildImages.sh $1

  ./dockerPushImages.sh $1

  ./githubCreateRelease.sh $1

fi
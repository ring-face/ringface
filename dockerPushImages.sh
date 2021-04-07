#!/bin/bash

if [ -z ${1+x} ]
  then
  echo "Please define semver to release. eg: ./dockerPushImages.sh 1.0.1"
  exit 1
  else

  echo "pushing versions to dockerhub '$1'"
  ../ringface-gui/dockerImagesPush.sh  $1
  ../ringface-classifier/dockerImagePush.sh $1
  ../ringface-connector/dockerImagesPush.sh $1

fi
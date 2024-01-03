#!/bin/bash

ID=698901871289
BASEDIR=$(dirname "$0")
docker build -t $ID.dkr.ecr.ap-southeast-1.amazonaws.com/cbnt-docker-demo-1:1 $BASEDIR/.
docker push $ID.dkr.ecr.ap-southeast-1.amazonaws.com/cbnt-docker-demo-1

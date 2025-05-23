#!/bin/bash

kubectl create ns details
kubectl create ns ratings
kubectl create ns reviews
kubectl create ns productpage

for ns in details reviews productpage ratings; do
  kubectl create secret docker-registry harbor-secret \
    --docker-server=harbor.kaunghtetsan.tech \
    --docker-username=<Username> \
    --docker-password=<Password> \
    -n $ns
done


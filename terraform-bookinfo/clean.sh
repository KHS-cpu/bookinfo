#!/bin/bash

rm -rf .terraform*
rm -rf terraform.tfstate*

kubectl delete ns details reviews productpage ratings

kubectl delete deploy details-v1 -n details
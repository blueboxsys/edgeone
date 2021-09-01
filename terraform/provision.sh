#!/bin/bash

set -x

echo "Provisioning edgeone default tenant infra..."

if [ -z ${AWS_PROFILE} ];
then
  AWS_PROFILE=default
fi

if [ -z ${REGION} ];
then
  REGION=eu-west-2
fi

terraform init

#terraform plan

terraform apply --auto-approve

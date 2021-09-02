#!/bin/bash

set -x

export AWS_SDK_LOAD_CONFIG=1

echo "Provisioning edgeone default tenant infra..."

if [ -z ${AWS_PROFILE} ];
then
  AWS_PROFILE=default
fi

if [ -z ${AWS_REGION} ];
then
  AWS_REGION=eu-west-2
fi

terraform init

#terraform plan

terraform apply --auto-approve

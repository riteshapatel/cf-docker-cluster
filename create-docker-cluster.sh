#!/bin/sh

################################################################################
# Script for testing docker cluster stack. It validates, removes an existing stack,
# validates template and creates a new docker cluster stack.
# Usage: ./create-docker-cluster.sh --capabilities CAPABILITY_NAMED_IAM
# @author ritesh patel
# @email ritesh@line89.com
# @date 10/09/2017
# Note: Modify TEMPLATE parameter with the location of your template file (line 18)
################################################################################
# AWS profile from .credentials
PROFILE='raptest'
# stack region
REGION='us-east-1'
# stack name
STACK_NAME='rap-dryrun-docker-cluster'
# replace location with the template on your machine :D
TEMPLATE='file://~/code/cf-docker-cluster/docker-cluster.template'

# validate template
echo 'validate template...'
aws cloudformation validate-template --profile $PROFILE --region $REGION --template-body $TEMPLATE
sleep 10s

# delete existing stack (if any)
echo 'deleting stack...'
aws cloudformation --profile $PROFILE --region $REGION delete-stack --stack-name $STACK_NAME
# wait for 3 minutes for the stack removal
sleep 15s

# create a new stack
echo 'creating stack...'
aws cloudformation --profile $PROFILE --region $REGION create-stack --stack-name $STACK_NAME --template-body $TEMPLATE --capabilities CAPABILITY_NAMED_IAM

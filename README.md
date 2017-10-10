# Installation Guide: Docker EE Cluster

Author: Ritesh Patel | Last Updated: Oct 11, 2017

## Overview

This guide supports the access, management, and deployment of the Docker EE Cluster from CloudFormation templates in Amazon Web Services

## Getting Started

The following sections provide guidance for using the template to configure and launch resources for Docker EE Cluster.

### Accessing the Templates

Main template file is called "docker-cluster.template". In the repository there is a bash
script to execute and tear down the stack. (if you wish to do it through AWS CLI, now of course you must install / configure CLI, duh!)

### Template File Structure

The master template repository is represented by the following tree Structure
```
├──
├── README.md
├── create-docker-cluster.sh
└── docker-cluster.template

```

#### Known Dependencies

This template does not create VPC, Subnets and Security Group(s). Template user must create these resources beforehand. Additionally, keypair must be modified to reflect the correct keypair from user's environment.

#### Parameters and Conditions

The templates use parameters to allow for dynamic provisioning of the related resources, allowing custom network, computer, and storage controls to be applied at runtime. The following table lists the known parameters and relevant conditions utilized by the resources during provisioning.

__Parameters__

| Parameter Identifier | Default Value |
|----------------------|---------------|
| pApplicationIdentifier | docker-ee-cluster |
| pApplicationName | Docker EE Cluster |
| pEC2AvailabilityZoneTarget | us-east-1a (replace with region of your choice) |
| pEC2InstanceType | t2.medium |
| pKeypair | keypair.pem |
| pServerAMI | ami-c998b6b2 |
| pDockerSubnetAza | az-a-subnet (must be replaced) |
| pDockerSubnetAzb | az-b-subnet (must be replaced) |
| pDockerVPC | vpc-84b702fd (must be replaced) |
| pDockerMinSize | 1 |
| pDockerMaxSize | 8 (adjust) |
| pDockerDesiredCapacity | 3 (adjust) |
| pDockerSecurityGroup | sg-440fc135 |
| pEnvironment | development |
| pRoleName | prd-docker-cluster-role |
| pTagProductOwner | Ritesh Patel |
| pCloudWatchActionsPolicy | | |  |
| pTagTechnicalContact | Ritesh Patel |
| pUniqueTimestampHash | 123456789 |
| pCloudWatchEventsPolicy | default |
| pCloudWatchInlinePolicyName | prd-inline-policy-docker-cluster |
| pInstanceProfileName | prd-instance-profile-docker-cluster |
| pEC2InstanceRootVolSize | 10G |
__Conditions__

| Condition Identifier | Parameters Referenced | Logical Operator Purpose |
|----------------------|----------------------|--------------------------|
| cLaunchAsDedicatedInstance | pVPCTenancy | Evaluates if EC2 instances should utilize dedicated hosts. <br><br>_Logical operation:_ If the tenancy parameter matches the string 'dedicated', return true |

### Resources Created by this Template

The following table lists the known resource types and identifiers created during runtime provisioning.

| Resource Name | Type |
|---------------|------|
| rIAMRole | IAM role with cloudwatch policies |
| rIAMInstanceProfile | Instance profile to attach with Docker ee nodes |
| rDockerLaunchConfig | Docker Launch Configuration |
| rDockerAutoScalingGroup | Docker Auto Scaling Group |

### Wait conditions

This template creates one wait condition to track the completion of rDockerLaunchConfig instance. Wait condition has a 30 minutes of timeout. In the event of a successful completion the wait condition receives a signal and marks the resource creation as complete else the entire stack is rolled back after 30 minutes. WaitCondition signal count is set to cluster's desired capacity.


### Template modifications

To use this template, you must replace following parameters with the actual values from your environment.

| Parameters to be replaced |
|-----------|
| pDockerVPC |
| pDockerSubnetAza |
| pDockerSubnetAzb |
| pServerAMI |
| pKeypair |

### Known Issues and Bugs
Gimme a holler if you find one :D :D :D

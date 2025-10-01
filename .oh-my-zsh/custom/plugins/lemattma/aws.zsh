#!/bin/bash

# Create a new directory and enter it
function aws_deploy_status() {
  aws cloudformation describe-stacks --query "Stacks[*].[StackName, StackStatus]" --output table
}

function aws_rds_snapshots() {
  aws rds describe-db-snapshots --query "DBSnapshots[*].[DBSnapshotIdentifier, Status]" --output table
}

function aws_rds_instances() {
  # aws rds describe-db-instances --query "DBInstances[*].DBInstanceIdentifier" --output text
  # aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier, DBInstanceStatus, StorageType, AllocatedStorage]" --output table
  aws rds describe-db-instances --query "DBInstances[*].DBInstanceIdentifier" --output json | jq -r '.[]' | while read db; do
    db_status=$(aws rds describe-db-instances --db-instance-identifier "$db" --query "DBInstances[0].DBInstanceStatus" --output text)
    storage_type=$(aws rds describe-db-instances --db-instance-identifier "$db" --query "DBInstances[0].StorageType" --output text)
    total_storage=$(aws rds describe-db-instances --db-instance-identifier "$db" --query "DBInstances[0].AllocatedStorage" --output text)
    free_storage=$(aws cloudwatch get-metric-statistics \
      --namespace AWS/RDS \
      --metric-name FreeStorageSpace \
      --dimensions Name=DBInstanceIdentifier,Value="$db" \
      --statistics Average \
      --period 86400 \
      --start-time $(date -u -v-1d +%Y-%m-%dT%H:%M:%SZ) \
      --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ) \
    --query 'Datapoints[0].Average' --output json | jq '. / 1073741824')
    
    used_storage=$(echo "$total_storage - $free_storage" | bc)
    echo "$db | Status: $db_status | Storage: $storage_type | Used: $used_storage GiB / $total_storage GiB"
  done
}

function aws_deploy_logs() {
  # Check if environment parameter is provided
  if [ -z "$1" ]; then
    echo "❌ Error: Environment parameter is required"
    echo "Usage: $0 <environment>"
    exit
  fi
  
  aws cloudformation describe-stack-events --stack-name $1 \
  --query "StackEvents[*].{Time:Timestamp, Resource:LogicalResourceId, Status:ResourceStatus, Reason:ResourceStatusReason}" \
  --output table
}

function aws_resources_by_env() {
  # Define the tag key and value
  TAG_KEY="Environment"
  TAG_VALUE=$1
  
  # Check if environment parameter is provided
  if [ -z "$1" ]; then
    echo "❌ Error: Environment parameter is required"
    echo "Usage: $0 <environment>"
    exit 0
  fi
  
  echo "🔍 Searching for AWS resources tagged as $TAG_VALUE..."
  
  # Get a list of AWS resource ARNs that have the tag "Environment=staging"
  aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=$TAG_KEY,Values="$TAG_VALUE" \
  --query 'ResourceTagMappingList[*].ResourceARN' \
  --output json | jq -r '.[]'
  
}


function aws_secrets() {
  aws secretsmanager get-secret-value --secret-id kcdbstaging-secret --query SecretString --output text | jq --arg new_host "kc-stag-db-kcstagdbd5a2895a-gz1moakco5gf.cfs0y4gi6x43.ap-southeast-2.rds.amazonaws.com" '.host=$new_host'
}

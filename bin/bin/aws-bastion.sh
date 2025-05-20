#!/bin/zsh

if [ -z "$AWS_PROFILE" ]; then
  echo "Please set AWS_PROFILE environment variable"
  exit 1
fi

aws sts get-caller-identity --query "Account" --profile $AWS_PROFILE &> /dev/null
if (($?)) then
  aws sso login
fi

INSTANCE=$(aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.Tags | any(.Value == "BastionHost")).InstanceId')
echo "Connecting to Bastion Host: ${INSTANCE}"
ssh ec2-user@$INSTANCE
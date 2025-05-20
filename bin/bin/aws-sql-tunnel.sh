#!/bin/zsh

if [ -z "$AWS_PROFILE" ]; then
  echo "Please set AWS_PROFILE environment variable"
  exit 1
fi

aws sts get-caller-identity --query "Account" --profile $AWS_PROFILE &> /dev/null
if (($?)) then
  aws sso login
fi

INSTANCE=$(aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select((.Tags | any(.Value == "BastionHost")) and (.State.Name == "running")).InstanceId')
echo "Using Bastion Host: ${INSTANCE}"

RDSHOSTSJSON=$(aws rds describe-db-instances --query 'DBInstances[*].{id:DBInstanceIdentifier,endpoint:Endpoint}')
RDSHOSTSCOUNT=$(jq 'length' <<< "$RDSHOSTSJSON")

if (( $RDSHOSTSCOUNT == 0 )); then
  echo "No items"
  exit 1
elif (( $RDSHOSTSCOUNT == 1 )); then
  RDSHOST=$(jq -r '.[0].endpoint.Address' <<< "$RDSHOSTSJSON")     # auto-pick the only item
  RDSPORT=$(jq -r '.[0].endpoint.Port' <<< "$RDSHOSTSJSON")
  echo "Using RDS Host $RDSHOST:$RDSPORT"
else
  RDSID=$(jq -r '.[].id' <<< "$RDSHOSTSJSON" | fzf --header 'Select RDS instance')  # let user pick
  RDSHOST=$(jq -r ".[] | select(.id == \"$RDSID\").endpoint.Address" <<< "$RDSHOSTSJSON")
  RDSPORT=$(jq -r ".[] | select(.id == \"$RDSID\").endpoint.Port" <<< "$RDSHOSTSJSON")
  echo "Using RDS Host $RDSHOST:$RDSPORT"
fi

ssh -L localhost:5444:$RDSHOST:$RDSPORT ec2-user@$INSTANCE

echo "Tunnelled $RDSHOST:$RDSPORT to localhost:5444"

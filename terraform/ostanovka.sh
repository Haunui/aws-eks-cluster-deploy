#!/usr/bin/bash

export $(cat .elb_cache | xargs)

echo "Suppression du load balancer .."
cd alb
terraform destroy -auto-approve -var "prefix=$PREFIX" -var "region=$REGION" -var "subnet_ids=$SUBNETS"
cd ..

rm .elb_cache

echo "Démontage de l'infrastructure .."
terraform destroy -auto-approve
echo "Infrastructure supprimée"

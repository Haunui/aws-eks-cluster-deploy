#!/usr/bin/bash

echo "Création de la base (vpc,subnet,sg,rtb,cluster,nodegroup) .."
DATA=$(terraform apply -auto-approve)
PREFIX=$(echo "$DATA" | grep "output-prefix" | cut -d'"' -f2)
REGION=$(echo "$DATA" | grep "output-region" | cut -d'"' -f2)
SUBNETS=$(echo "$DATA" | grep "output-subnets" | cut -d'"' -f2)

cd alb
echo "Création du load balancer .."
DATA=$(terraform apply -auto-approve -var "prefix=$PREFIX" -var "region=$REGION" -var "subnet_ids=$SUBNETS")
LBURL=$(echo "$DATA" | grep "output-lburl" | cut -d'"' -f2)
cd ..

touch .elb_cache
echo "PREFIX=$PREFIX" >> .elb_cache
echo "REGION=$REGION" >> .elb_cache
echo "SUBNETS=$SUBNETS" >> .elb_cache

echo "url d'accès : "
echo "$LBURL"

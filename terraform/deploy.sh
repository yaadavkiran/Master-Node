#!/bin/bash

sudo mkdir -p /ansible
sudo chmod 777 /ansible
sudo terraform init
sudo terraform apply -auto-approve -lock=false
sudo terraform output -json | jq -r '.[keys[0]].value[]','.[keys[1]].value[]' > /tmp/hosts
awk 'NR==1{print "[Master]"}1 && NR==2{print " "}1 && NR==2{print "[Workers]"}1' /tmp/hosts > /ansible/hosts
sleep 30
cd /ansible
ansible-playbook main.yaml -i hosts
ansible-playbook k8.yaml -i hosts --limit 'Master'

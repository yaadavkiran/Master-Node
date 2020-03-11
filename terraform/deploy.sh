#!/bin/bash

sudo terraform init
sudo terraform apply -auto-approve -lock=false
sudo terraform output -json | jq -r '.[keys[0]].value[]','.[keys[1]].value[]' > /tmp/hosts
awk 'NR==1{print "[Master]"}1 && NR==2{print " "}1 && NR==2{print "[Workers]"}1' /tmp/hosts > /project/Master-Node/ansible/hosts
sleep 30
sudo chmod 777 /project/Master-Node/ansible/
cd /project/Master-Node/ansible/
ansible-playbook main.yaml -i hosts
ansible-playbook k8.yaml -i hosts --limit 'Master'

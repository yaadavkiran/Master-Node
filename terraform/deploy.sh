#!/bin/bash
cd /project/Master-Node/terraform
sudo terraform init
sudo terraform apply -auto-approve -lock=false
sudo touch /tmp/hosts /project/Master-Node/ansible/hosts
sudo chmod 777 /tmp/hosts /project/Master-Node/ansible/hosts
sudo terraform output -json | jq -r '.[keys[0]].value[]','.[keys[1]].value[]' > /tmp/hosts
sudo awk 'NR==1{print "[Master]"}1 && NR==2{print " "}1 && NR==2{print "[Workers]"}1' /tmp/hosts > /project/Master-Node/ansible/hosts
sleep 30
export ANSIBLE_HOST_KEY_CHECKING=False
cd /project/Master-Node/ansible/
ansible-playbook main.yaml -i hosts
ansible-playbook k8.yaml -i hosts --limit 'Master'

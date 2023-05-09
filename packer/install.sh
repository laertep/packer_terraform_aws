#!/bin/bash
ls /tmp
ls /tmp/ansible
sudo apt-get update
sudo apt-get -y install ansible
ansible-playbook --connection=local /tmp/ansible/playbook.yml
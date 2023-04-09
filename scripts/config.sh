#!/bin/bash
set -eu

pushd infra/tf

ansible -i modules/ansible/inventory.ini -m ping all

ansible-playbook -i modules/ansible/inventory.ini modules/ansible/setup.yaml

popd


# ansible config copy ->
# [ ~/.ansible.cfg ]

# [defaults]
# remote_user = ubuntu
# host_key_checking = False
# inventory=/etc/ansible/hosts
# #private_key_file=~/.ssh/id_rsa_ansible_main.pem
# #command_warnings=false

# [ssh_connection]
# control_path=%(directory)s/%%h-%%r
# control_path_dir=~/.ansible/cp
# #pipelining = True
# scp_if_ssh = True
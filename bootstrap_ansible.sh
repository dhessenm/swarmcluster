#!/bin/bash

VAGRANT_SSH_KEY=/home/vagrant/.ssh/id_rsa

echo "Installing Ansible..."
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible

echo "Copy inventory file to default location (/etc/ansible/hosts)"
[ -f /vagrant/provision/hosts/hosts ] && cp /vagrant/provision/hosts/hosts /etc/ansible/hosts

echo "Copy ansible.cfg to default location (/etc/ansible/ansible.cfg)"
[ -f /vagrant/provision/ansible.cfg ] && cp /vagrant/provision/ansible.cfg /etc/ansible/ansible.cfg


if [[ ! -f $VAGRANT_SSH_KEY ]]; then
  echo "Generate SSH key for user vagrant ..."
  su - vagrant -c "ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -N \"\" " || exit 1
else
  echo "Vagrant SSH key already exists."
fi

su - vagrant -c "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"

echo "Copy SSH Key to local file master_id_rsa.pub..."
[ -f /home/vagrant/.ssh/id_rsa.pub ] && cp /home/vagrant/.ssh/id_rsa.pub /vagrant/master_id_rsa.pub  || exit 2

exit 0



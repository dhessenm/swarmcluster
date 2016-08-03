#!/bin/bash

VAGRANT_SSH_KEY=/vagrant/master_id_rsa.pub

echo "Update Cache ..."
apt-get update

echo "Copy vagrant pub ssh key into file authorized_keys..."
if [[ -f $VAGRANT_SSH_KEY ]];then
  su - vagrant -c "cat $VAGRANT_SSH_KEY >> /home/vagrant/.ssh/authorized_keys"
else
  echo "Vagrant ssh key file $VAGRANT_SSH_KEY not found."
fi

echo "create host file entries..."
cat /vagrant/hostfile >> /etc/hosts





#!/bin/bash

VAGRANT_SSH_KEY=/home/vagrant/.ssh/id_rsa


# configure proxy settings if proxy is set
if [[ ! -z $PROXY ]]; then
  echo "Set proxy $PROXY"
  export http_proxy=$1
  export https_proxy=$1
  export HTTP_PROXY=$1
  export HTTPS_PROXY=$1
  export NO_PROXY=.intranet.deutschebahn.com,.db.de,localhost,127.0.0.1
  echo 'Acquire::http::proxy "'$PROXY'";' > /etc/apt/apt.conf
  echo 'Acquire::https::proxy "'$PROXY'";' >> /etc/apt/apt.conf
fi


echo "Installing Ansible..."
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible git

echo "Copy inventory file to default location (/etc/ansible/hosts)"
[ -f /vagrant/provisioning/environments/vagrant ] && cp /vagrant/provisioning/environments/vagrant /etc/ansible/hosts

echo "Copy ansible.cfg to default location (/etc/ansible/ansible.cfg)"
[ -f /vagrant/provisioning/ansible.cfg ] && cp /vagrant/provisioning/ansible.cfg /etc/ansible/ansible.cfg


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




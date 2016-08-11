#!/bin/bash

VAGRANT_SSH_KEY=/vagrant/master_id_rsa.pub

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






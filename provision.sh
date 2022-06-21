#!/bin/bash

cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update

sudo apt-get update
sudo apt-get install -y \
  docker docker-compose \
  direnv net-tools curl ntp \
  build-essential gcc make \
  rpm librpm-dev rpm-common \
  vault postgresql-client redis-tools \
  ffmpeg mediainfo

echo 'eval "$(direnv hook bash)"' >> /home/vagrant/.bashrc

echo "setting up docker..."
sudo adduser vagrant docker
newgrp docker

echo "mounting volumes..."
sudo mkdir -p /mnt/maus-data-gitlab
sudo mount 192.168.0.10:/home/mihado/Services/.data/gitlab /mnt/maus-data-gitlab

echo "installing go..."
curl -OL https://go.dev/dl/go1.17.11.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.11.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile > /dev/null


echo "installing gitlab-runner..."
RUNNER_PACKAGE="gitlab-runner_amd64.deb"
if [ ! -f "$RUNNER_PACKAGE" ]; then
    curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/${RUNNER_PACKAGE}"
fi

sudo dpkg -i "$RUNNER_PACKAGE"
sudo usermod -aG docker gitlab-runner

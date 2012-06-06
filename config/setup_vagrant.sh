#!/bin/sh

apt-get -y update
apt-get -y upgrade
apt-get -y install git-core curl vim
apt-get -y install build-essential
apt-get -y install zlib1g-dev libssl-dev
apt-get -y install libreadline5-dev libffi libyaml
echo "America/New_York" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
useradd -G admin -m -s /bin/bash -p haHH78/hbDTnQ deployer 2>&1
su deployer
cd /home/deployer
git clone git://github.com/sstephenson/rbenv.git .rbenv 2>&1
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc
echo 'eval "$(rbenv init -)"' >> .bashrc
export PATH="/home/deployer/.rbenv/bin:$PATH"
rbenv init -
wget -N http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz 2>&1
tar -xzvf ruby-1.9.3-p194.tar.gz
cd /home/deployer/ruby-1.9.3-p194
./configure --prefix=/home/deployer/.rbenv/versions/1.9.3-p194
make
make install
cd /home/deployer
cp -R /home/vagrant/.ssh /home/deployer/
chown -R deployer:deployer /home/deployer
rm ruby-1.9.3-p194.tar.gz
halt 2>&1

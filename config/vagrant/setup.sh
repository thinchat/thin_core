#!/bin/sh

apt-get -y update
apt-get -y upgrade
apt-get -y install git-core curl vim
apt-get -y install build-essential
apt-get -y install zlib1g-dev libssl-dev
apt-get -y install libreadline5-dev libffi-dev libyaml-dev
echo "America/New_York" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
wget -N http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
tar -xvf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194
./configure
make
make install
gem install bundler
gem install god
gem install chef
git clone git://github.com/thinchat/thin_chef.git /var/chef
chef-solo -c /var/chef/solo.rb
mkdir /usr/local/var
mkdir /usr/local/var/db
mkdir /usr/local/var/db/redis

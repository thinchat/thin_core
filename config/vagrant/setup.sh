#!/bin/sh

apt-get -y update
apt-get -y upgrade
apt-get -y install git-core curl vim libffi-dev
echo "America/New_York" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
curl -L https://raw.github.com/gist/2910634/8ddbbe9c3c95782bc37bc0a1d261265d5afedebe/chef_solo_bootstrap.sh | bash
gem install chef ruby-shadow --no-ri --no-rdoc
gem install bundler
gem install god
git clone git://github.com/thinchat/thin_chef.git /var/chef
chef-solo -c /var/chef/solo.rb
mkdir /usr/local/var
mkdir /usr/local/var/db
mkdir /usr/local/var/db/redis

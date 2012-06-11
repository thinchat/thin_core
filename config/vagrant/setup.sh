#!/bin/sh

apt-get -y update
apt-get -y upgrade
apt-get -y install git-core curl vim libffi-dev
echo "America/New_York" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
curl -L https://raw.github.com/gist/2828151/ff2d251c9f4f149c5ca73c873ad8990711b3ca74/chef_solo_bootstrap.sh | bash
gem install chef ruby-shadow --no-ri --no-rdoc
gem install bundler
gem install god
git clone git://github.com/thinchat/thin_chef.git /var/chef
chef-solo -c /var/chef/solo.rb
mkdir /usr/local/var
mkdir /usr/local/var/db
mkdir /usr/local/var/db/redis

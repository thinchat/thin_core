set :host, "localhost"
role :web, host
role :app, host
role :db, host, :primary => true
ssh_options[:port] = "2222"

set :application, "thin_core"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
# set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:thinchat/#{application}.git"
set :branch, "chris_vagrant"

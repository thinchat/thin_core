server "127.0.0.1", :web, :app, :db, primary: true
set :port, 2222

set :application, "thin_core"
set :user, "vagrant"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:thinchat/#{application}.git"
set :branch, "master"

set :default_environment, {
  'PATH' => "/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:$PATH"
}

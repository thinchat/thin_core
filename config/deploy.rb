require "bundler/capistrano"
require 'capistrano/ext/multistage'

set :stages, %w(production development staging)
set :default_stage, "development"

set :application, "thin_core"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :scm, "git"
set :repository, "git@github.com:thinchat/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:nginx:config", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  desc "Deploy to Vagrant (assumes you've run 'rake vagrant:setup')"
  task :vagrant, roles: :app do
    puts "Deploying to Vagrant..."
  end
  after "deploy:vagrant", "deploy:setup", "deploy", "deploy:nginx:restart"

  desc "Push secret files"
  task :secret, roles: :app do
    run "mkdir #{release_path}/config/secret"
    run "mkdir -p #{shared_path}/config"
    transfer(:up, "config/secret/redis_password.rb", "#{release_path}/config/secret/redis_password.rb", :scp => true)
    transfer(:up, "config/secret/redis.conf", "/home/deployer/redis.conf", :scp => true)
    transfer(:up, "config/secret/database.production.yml", "#{shared_path}/config/database.yml", :scp => true)
    sudo "mv /home/deployer/redis.conf /etc/redis/redis.conf"
    require "./config/secret/redis_password.rb"
    sudo "/usr/bin/redis-cli config set requirepass #{REDIS_PASSWORD}"
  end
  before "deploy:symlink_config", "deploy:secret"

  desc "Create the production database"
  task :create_database, roles: :app do
    run "cd #{release_path} && bundle exec rake RAILS_ENV=production db:create"
  end
  after "deploy:symlink_config", "deploy:create_database"

  desc "Setup unicorn configuration"
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end
  after "deploy:setup", "deploy:create_release_dir", "deploy:setup_config"

  task :create_release_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :releases_path}"
  end

  desc "Symlink shared/database.yml to config/database.yml"
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  namespace :nginx do
    desc "Restart Nginx"
    task :restart, roles: :app do
      sudo "service nginx restart"
    end

    desc "Copy nginx.conf to thinchat/config and symlink to /etc/nginx/sites-enabled/default "
    task :config, roles: :app do
      sudo "ln -nfs #{release_path}/config/nginx.conf /etc/nginx/sites-enabled/default"
    end
  end
end

desc "Provision server"
task :provision do
  response = Capistrano::CLI.ui.ask "Are you sure you want to provision this server? [y/n]"
  if response == 'y' || response == 'yes'
    set :user, "root"
    transfer(:up, "config/vagrant/setup.sh", "setup.sh", :scp => true)
    sudo "chmod +x setup.sh"
    sudo "./setup.sh"
    sudo "mkdir /home/deployer/.ssh"
    sudo "chmod 700 /home/deployer/.ssh"
    transfer(:up, "~/.ssh/id_rsa.pub", "/home/deployer/.ssh/authorized_keys", :scp => true)
    sudo "chmod 644 /home/deployer/.ssh/authorized_keys"
  else
    puts "Phew. That was a close one eh?"
  end
end

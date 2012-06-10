namespace :dev do
  desc "Setup Vagrant"
  task :setup do
    env = Vagrant::Environment.new(:ui_class => Vagrant::UI::Colored)
    puts "Adding lucid32.box as 'development'..."
    puts `vagrant box add development http://files.vagrantup.com/lucid32.box`
    puts `cp config/vagrant/vagrantfile.pre_chef Vagrantfile`
    puts `vagrant up`
    puts `vagrant halt`
    puts `cp config/vagrant/vagrantfile.post_chef Vagrantfile`
    puts `vagrant up`
    puts `Finished! VM available at 27.27.27.27`
  end

  desc "Setup Vagrant and deploy this application"
  task :provision do
    puts `cap deploy:setup`
    puts `cap deploy`
  end

  desc "Start Vagrant"
  task :start do
    env = Vagrant::Environment.new(:ui_class => Vagrant::UI::Colored)
    puts "Starting Vagrant..."
    env.cli("up")
  end

  desc "Restart Vagrant"
  task :restart do
    env = Vagrant::Environment.new(:ui_class => Vagrant::UI::Colored)
    puts "Restarting Vagrant..."
    env.cli("reload")
  end

  desc "Shutdown Vagrant"
  task :shutdown do
    env = Vagrant::Environment.new(:ui_class => Vagrant::UI::Colored)
    raise "Run 'vagrant up' to create your Vagrant" if !env.primary_vm.created?
    raise "Vagrant isn't running" if env.primary_vm.state != :running
    puts "Shutting down Vagrant..."
    env.primary_vm.channel.sudo("halt")
  end

  desc "Destructobomb Vagrant"
  task :implode do
    env = Vagrant::Environment.new(:ui_class => Vagrant::UI::Colored)
    puts `vagrant destroy --force`
    puts `vagrant box remove development`
    puts `rm Vagrantfile`
  end
end

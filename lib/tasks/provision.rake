require 'net/scp'

desc "Provision server at a given IP 'rake provision[127.0.0.1, user*]' *default is root"
task :provision, :ip, :user do |t, args|
  ip, user = args[:ip], args[:user]
  user ||= 'root'
  `stty -echo`
  puts "Password for #{user}@#{ip}:"
  password = STDIN.gets.chomp
  `stty echo`

  if ip
    puts "Uploading..."
    Net::SCP.start(ip, user, :password => password) do |scp|
      scp.upload! "config/vagrant/setup.sh", "/home/root" do |ch, name, sent, total|
        puts "#{name}: #{sent}/#{total}"
      end
    end
  else
    puts "Must include at least IP of target server."
    puts "e.g. rake provision[127.0.0.1, user*]"
    puts "*user defaults to root"
  end
end

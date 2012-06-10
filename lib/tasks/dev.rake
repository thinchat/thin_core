namespace :dev do
  desc "Setup local development environment"
  task :setup do
    Rake::Task["vagrant:setup"].invoke
    puts `cap deploy:setup`
    puts `cap deploy`
  end
end

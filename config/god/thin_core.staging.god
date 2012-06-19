application = 'thin_core'
rails_env = 'staging'

require "/home/deployer/apps/#{application}/current/config/secret/campfire_token.rb"
rails_root = "/home/deployer/apps/#{application}/current"

God.watch do |w|
  w.name = "#{application}"
  w.log = "/var/log/god/#{application}.log"
  w.err_log = "/var/log/god/#{application}_error.log"
  w.uid = 'deployer'
  w.gid = 'admin'
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.interval = 30.seconds
  w.behavior(:clean_pid_file)
  w.pid_file = "#{rails_root}/tmp/pids/unicorn.pid"

  # unicorn needs to be run from the rails root
  w.start = "cd #{rails_root} && bundle exec unicorn -c #{rails_root}/config/unicorn.rb -E #{rails_env} -D"

  # QUIT gracefully shuts down workers
  w.stop = "kill -QUIT `cat #{rails_root}/tmp/pids/unicorn.pid`"

  # USR2 causes the master to re-create itself and spawn a new worker pool
  w.restart = "kill -USR2 `cat #{rails_root}/tmp/pids/unicorn.pid`"

  # determine when process has finished starting
  w.transition([:start, :restart], :up) do |on|
    on.condition(:process_running) do |c|
      c.running = true
      c.interval = 5.seconds
      c.notify = 'ha_campfire'
    end

    # failsafe
    on.condition(:tries) do |c|
      c.times = 5
      c.transition = :start
      c.interval = 5.seconds
      c.notify = 'ha_campfire'
    end
  end

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
      c.notify = 'ha_campfire'
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
      c.notify = 'ha_campfire'
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
      c.notify = 'ha_campfire'
    end
  end

  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
      c.notify = 'ha_campfire'
    end
  end
end

3.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "core_resque_worker_#{num}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.pid_file = "#{rails_root}/tmp/pids/#{w.name}.pid"
    w.env      = {"QUEUE"=>"messages", "RAILS_ENV"=>rails_env, 'PIDFILE' => w.pid_file}
    w.start    = "/usr/local/bin/rake -f #{rails_root}/Rakefile environment resque:work"
    w.log = "/var/log/god/#{w.name}.log"
    w.err_log = "/var/log/god/#{w.name}_error.log"

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 350.megabytes
        c.times = 2
        c.notify = 'ha_campfire'
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.notify = 'ha_campfire'
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
        c.notify = 'ha_campfire'
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
        c.notify = 'ha_campfire'
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
        c.notify = 'ha_campfire'
      end
    end
  end
end

God::Contacts::Campfire.defaults do |d|
  d.subdomain = 'hungrymachine'
  d.token     = CAMPFIRE_TOKEN
  d.room      = 'HA Team 6'
  d.ssl       = true
end

God.contact(:campfire) do |c|
  c.name = 'ha_campfire'
end

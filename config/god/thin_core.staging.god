require '/home/deployer/apps/thin_core/current/config/secret/campfire_token.rb'

God.watch do |w|
  w.name = 'thin_core'
  w.dir = '/home/deployer/apps/thin_core/current'
  w.start = "/etc/init.d/unicorn_thin_core start"
  w.stop = "/etc/init.d/unicorn_thin_core stop"
  w.restart = "/etc/init.d/unicorn_thin_core restart"
  w.log = '/var/log/god/thin_core.log'
  w.env = { 'RAILS_ENV' => 'staging' }
  w.uid = 'deployer'
  w.gid = 'admin'
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.interval = 30.seconds
  w.behavior(:clean_pid_file)

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

God::Contacts::Campfire.defaults do |d|
  d.subdomain = 'hungrymachine'
  d.token     = CAMPFIRE_TOKEN
  d.room      = 'HA Team 6'
  d.ssl       = true
end

God.contact(:campfire) do |c|
  c.name = 'ha_campfire'
end

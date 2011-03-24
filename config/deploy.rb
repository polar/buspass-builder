#
# Settings for Capistrano
#
set :application, "buspass-builder"
set :rails_env, "production"

# Deployment From Source Code Management (SCM)
set :scm, :git
set :scm_username, "polar"
set :repository,  "git://github.com/polar/buspass-builder.git"
set :git_enable_submodules, 1

# If we need a SSH Tunnel to get out or get to the remote server.
# Sadly, I think this applies to all out going connections.
#set :gateway, "polar@adiron.kicks-ass.net:922"

# Remote Server
# The app has its own user id.
set :deploy_to, "~buspass/buspass-builder"
set :use_sudo, false
set :user, "buspass"

# Not sure about monit yet.
#set :monit_group, "buspass"

#role :app, "buspass@suoc.syr.edu:922"
#role :web, "buspass@suoc.syr.edu:922"
#role :db,  "buspass@suoc.syr.edu:922", :primary => true
# 184.106.109.126 is adiron.com until DNS flushes
server "buspass@adiron.com", :web, :app, :db, :primary => true
#server "buspass@192.168.99.3", :web, :app, :db, :primary => true

namespace :buspass do
  task :createdb, :roles => :db  do
    run("cd buspass-builder/current;export RAILS_ENV=#{rails_env};rake db:migrate")
    run("cd buspass-builder/current;export RAILS_ENV=#{rails_env};rake db:seed")
  end
  task :load_uris, :roles => :db  do
    run("cd buspass-builder/current;export RAILS_ENV=#{rails_env};rake buspass:load_uris")
  end
  task :rebuild, :roles => :db  do
    stream("cd buspass-builder/current;export RAILS_ENV=#{rails_env}rake buspass:rebuild")
  end
  task :create_api, :roles => :db  do
    run("cd buspass-builder/current;export RAILS_ENV=#{rails_env};rake buspass:create_api")
  end
  task :start_sim, :roles => :app  do
    stream("cd buspass-builder/current;export RAILS_ENV=#{rails_env};script/runner 'Delayed::Job.enqueue DelayedSimulation.new(10)' 2>&1 1> log/simulate.log")
  end

end

namespace :delayed_job do

  desc "Clear Jobs"
  task :clear, :roles => :app do
    run "cd #{current_path};export RAILS_ENV=#{rails_env};rake jobs:clear")
  end

  desc "Start delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; script/delayed_job start #{rails_env}"
  end

  desc "Stop delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; script/delayed_job stop #{rails_env}"
  end

  desc "Restart delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; script/delayed_job restart #{rails_env}"
  end
end

after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:restart"


namespace :deploy  do
  task :start do
  end
  task :restart do
  end
end

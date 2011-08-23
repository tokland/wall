require 'capistrano/ext/multistage'

# Multi-staging

set :stages, %w(staging production)
set :default_stage, "staging"

# Passenger

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  task :link_shared_directories do     
    #run "ln -s #{shared_path}/signs #{release_path}/db/signs"   
  end    

  after "deploy:update_code", "deploy:link_shared_directories"  
end

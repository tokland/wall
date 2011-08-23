set :rails_env, "staging"
set :application, "wall"
set :scm, "git"
set :repository, "git@zaudera.com:git/ibcmass/wall"

role :web, "zaudera"
role :app, "zaudera"
role :db, "zaudera", :primary => true
set :deploy_to, "/home/wall/staging"
set :user, 'wall'
set :keep_releases, 3

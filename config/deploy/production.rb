set :rails_env, "production"
set :application, "reports"
set :scm, "git"
set :repository,  "git@zaudera.com:git/ipsvial/reports"

role :web, "fomento-sen.com"
role :app, "fomento-sen.com"
role :db, "fomento-sen.com", :primary => true
set :deploy_to, "/home/rails/production/reports"
set :user, 'rails'
set :keep_releases, 5

require 'bundler/capistrano'


set :rvm_ruby_string, "ruby-1.9.2-p320@misere"
require 'rvm/capistrano'


set :application, "misere"
set :repository,  "git@github.com:wjoneil/misere.git"

# set :default_environment, {
#   'PATH' => "/home/misere/.rvm/gems/ruby-1.9.2-p320@misere/bin:/home/misere/.rvm/gems/ruby-1.9.2-p320@global/bin:/home/misere/.rvm/rubies/ruby-1.9.2-p320/bin:/home/misere/.rvm/bin:$PATH",
# }

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :keep_releases, 3

role :web, "misere.co.nz"                          # Your HTTP server, Apache/etc
role :app, "misere.co.nz"                          # This may be the same as your `Web` server
role :db,  "misere.co.nz", :primary => true # This is where Rails migrations will run

set :deploy_to,               "/home/#{application}"
set :user,                    "misere"
set :use_sudo, false

set :rails_env, "production"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

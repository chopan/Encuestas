set :application, "encuestas"
set :repository,  "git://github.com/rgechavarria/Encuestas.git"
set :port, 65535
set :use_sudo, false

set :keep_releases, 5

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/webapps/#{application}"
set :domain, "lugia.uach.mx"
set :user, "rivazquez"
set :rails_env, "production"
set :use_sudo, true
set :rvm_location, "/usr/local/rvm/gems/ruby-1.9.2-p290/bin"


role :web, "lugia.uach.mx"                          # Your HTTP server, Apache/etc
role :app, "lugia.uach.mx"                          # This may be the same as your `Web` server
role :db,  "lugia.uach.mx", :primary => true # This is where Rails migrations will run
role :db,  "lugia.uach.mx"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

after "deploy:update", "deploy:cleanup"
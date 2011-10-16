set :application, "fake-mm"
set :repository,  "git@github.com:madbox/fake-mm.git"

dpath = "/home/hosting_madbox/projects/fake-mm"

set :user, "hosting_madbox"
set :use_sudo, false
set :deploy_to, dpath

set :scm, :git

role :web, "hydrogen.locum.ru"                          # Your HTTP server, Apache/etc
role :app, "hydrogen.locum.ru"                          # This may be the same as your `Web` server
role :db,  "hydrogen.locum.ru", :primary => true # This is where Rails migrations will run

after "deploy:update_code", :copy_database_config

task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

set :unicorn_rails, "/var/lib/gems/1.8/bin/unicorn_rails"
set :unicorn_conf, "/etc/unicorn/fake-mm.madbox.rb"
set :unicorn_pid, "/var/run/unicorn/fake-mm.madbox.pid"

# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run "#{unicorn_rails} -Dc #{unicorn_conf}"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_rails} -Dc #{unicorn_conf}"
  end
end

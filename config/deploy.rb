require 'capistrano/ext/multistage'

set :scm, :git
set :deploy_via, :export
#set :deploy_via, :copy
set :copy_strategy, :export
set :copy_exclude, [".git/*", ".svn/*"]
set :user, :rails
set :runner, :rails
set :use_sudo, false
set :application, "amazon"
set :deploy_to, "/home/rails/amazon"
# set :repository, svn+ssh://test.example.com/repository/trunk
set :repository, "rails@203.23.28.91:/var/git/amazon.git"

namespace :mod_rails do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "touch  #{release_path}/tmp/restart.txt"
  end
end

namespace :backgroundrb do
  desc <<-DESC
  Restart backgroundrb.
  DESC
  task :restart, :roles => :app do
    run "#{release_path}/script/backgroundrb stop"
    run "#{release_path}/script/backgroundrb start"
  end
end


namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
  %w(start restart).each { |name| task name, :roles => :app do backgroundrb.restart end }
end



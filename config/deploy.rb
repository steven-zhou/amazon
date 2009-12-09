require 'capistrano/ext/multistage'

set :scm, :git
# set :deploy_via, :export
set :deploy_via, :copy
set :copy_strategy, :export
set :copy_exclude, [".git/*", ".svn/*"]
set :user, :rails
set :runner, :rails
set :use_sudo, false
set :application, "amazon"
set :deploy_to, "/home/rails/amazon"
# set :repository, svn+ssh://test.example.com/repository/trunk
set :repository, "rails@amazon-development:/var/git/amazon.git"

namespace :mod_rails do
    desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
    DESC
    task :restart, :roles => :app do
        run "touch  #{release_path}/tmp/restart.txt"
    end
end


namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
  puts "\n\n\n\n\n ********* IMPORTANT *********\n You will need to manually restart backgroundrb on the server you are deploying to. To do this:\n\n"
  puts "  1 - ssh into the server (ie ssh rails@<server>)\n  2 - cd amazon/current\n  3 - ./script/backgroundrb restart\n\n"
  puts " ****************************\n\n\n\n\n"
  # %w(start restart).each { |name| task name, :roles => :app do backgroundrb.restart end }

end
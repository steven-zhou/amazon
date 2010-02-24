class NightlyProcessesController < ApplicationController
  # for testing only

  def index

    respond_to do |format|
      format.html
    end
  end

  def run
    cmd = "/usr/bin/ruby /usr/bin/rake -f #{RAILS_ROOT}/Rakefile rake:db:nightly_process_tasks RAILS_ENV=#{RAILS_ENV}"
    system  "#{cmd}"
    respond_to do |format|
      format.js
    end
  end
end


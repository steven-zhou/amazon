class ReportsController < ApplicationController


  def index
    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = Array.new
    c = Array.new
    @group_types.each do |group_type|
      a = group_type.list_headers
      c += a
      @list_headers = c.uniq
    end
    puts "**** DEBUG #{@list_headers.class} #{@list_headers.to_yaml}"
  end

  def generate_report
    report_format = params[:report][:format]
    report_name = params[:report][:name]
    report_list = params[:report][:list]

    puts "*****DEBUG got passed #{report_format} #{report_name} #{report_list}"


  end

  private
  

end

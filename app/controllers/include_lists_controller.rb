class IncludeListsController < ApplicationController
  # Logging stuff added

  def create    
    @list_header_ids = Array.new
    puts "#{params[:list_header_id].split(",")} EOD"
    params[:list_header_id].split(",").each do |id|
      @include_list = IncludeList.new
      @include_list.list_header_id = id
      @include_list.login_account_id = params[:login_account_id]
      @include_list.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) IncludeList created with ID #{@include_list.id}.")
      @list_header_ids << id
    end
    @include_lists = IncludeList.find_all_by_login_account_id(params[:login_account_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @include_list = IncludeList.find(params[:id].to_i)
    @list_header_id = String.new
    @list_header_id = @include_list.list_header_id
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted IncludeList with ID #{@include_list.id}.")
    @include_list.destroy
    respond_to do |format|
      format.js
    end
  end
end

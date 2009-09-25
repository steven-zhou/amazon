class ExcludeListsController < ApplicationController

  def create
    @exclude_list = ExcludeList.new
    @exclude_list.list_header_id = params[:list_header_id]
    @exclude_list.login_account_id = params[:login_account_id]
    @list_header_id = String.new
    @list_header_id = params[:list_header_id]
    @exclude_list.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @exclude_list = ExcludeList.find(params[:id].to_i)
    @list_header_id = String.new
    @list_header_id = @exclude_list.list_header_id
    @exclude_list.destroy
    respond_to do |format|
      format.js
    end
  end
end

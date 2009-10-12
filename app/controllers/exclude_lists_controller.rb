class ExcludeListsController < ApplicationController

  def create
    @exclude_list = ExcludeList.new
    @exclude_list.list_header_id = params[:list_header_id]
    @exclude_list.login_account_id = params[:login_account_id]
    @list_header_id = String.new
    @list_header_id = params[:list_header_id]
    @list_header = ListHeader.find(@list_header_id)
    @flag = true
    if @list_header.class.to_s != "PrimaryList"
      @exclude_list.save
    else
      @flag = false
    end
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

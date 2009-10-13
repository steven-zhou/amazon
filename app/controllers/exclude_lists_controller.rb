class ExcludeListsController < ApplicationController


  def create
    @list_header_ids = Array.new
    @flag = true
    params[:list_header_id].split(",").each do |id|
      @exclude_list = ExcludeList.new
      @exclude_list.list_header_id = id
      @exclude_list.login_account_id = params[:login_account_id]
      @list_header = ListHeader.find(id)

      if @list_header.class.to_s != "PrimaryList"
        @exclude_list.save
        @list_header_ids << id
      else
        @flag = false
      end
    end
    @exclude_lists = ExcludeList.find_all_by_login_account_id(params[:login_account_id])
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

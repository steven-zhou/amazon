class IncludeListsController < ApplicationController


  def create
    @include_list = IncludeList.new
    @include_list.list_header_id = params[:list_header_id]
    @include_list.login_account_id = params[:login_account_id]
    @list_header_id = String.new
    @list_header_id = params[:list_header_id]
    @include_list.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @include_list = IncludeList.find(params[:id].to_i)
    @list_header_id = String.new
    @list_header_id = @include_list.list_header_id
    @include_list.destroy
    respond_to do |format|
      format.js
    end
  end
end

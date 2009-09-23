class CompileListsController < ApplicationController

  def clear
    @compile_lists = CompileList.find_all_by_login_account_id(params[:login_account_id])
    @compile_lists.each do |i|
      i.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def compile
    @compile_lists = CompileList.find_all_by_login_account_id(params[:login_account_id])
    @person_ids = Array.new
    include_array = Array.new
    exclude_array = Array.new
    @compile_lists.each do |i|
      include_array.push(i) if (i.class =="IncludeList")
      exclude_array.push(i) if (i.class =="ExcludeList")
    end

    include_array.each do |i|
      @list_header = ListHeader.find(i.list_header.id)
      @list_details = @list_header.list_details
    end
  end
end

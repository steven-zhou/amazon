class IncludeListsController < ApplicationController
  # Logging stuff added

  def create    
    @list_header_ids = Array.new
    params[:list_header_id].split(",").each do |id|

      #      @include_list = IncludeList.new

      if params[:type]=="org"
        @include_list = OrganisationIncludeList.new
      end
      if params[:type]=="person"
        @include_list = PersonIncludeList.new
      end

      @include_list.list_header_id = id
      @include_list.login_account_id = params[:login_account_id]
      @include_list.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) IncludeList created with ID #{@include_list.id}.")
      @list_header_ids << id
    end
#    @include_lists = IncludeList.find_all_by_login_account_id(params[:login_account_id])
    if params[:type]=="org"
      @include_lists = OrganisationIncludeList.find_all_by_login_account_id(params[:login_account_id])
    end

     if params[:type]=="person"
      @include_lists = PersonIncludeList.find_all_by_login_account_id(params[:login_account_id])
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy

    @include_list = PersonIncludeList.find(params[:id].to_i) rescue @org_or_person = "org"
    if @org_or_person =="org"
      @include_list = OrganisationIncludeList.find(params[:id].to_i)
    end
    if @org_or_person =="person"
      @include_list = PersonIncludeList.find(params[:id].to_i)
    end

       
    @list_header_id = String.new
    @list_header_id = @include_list.list_header_id
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted IncludeList with ID #{@include_list.id}.")
    @include_list.destroy
#    @include_list_all = IncludeList.find(:all) to check the IncludeList is empty or not , in order to disabe the submit and clear button
    if @org_or_person =="org"
      @include_list_all = OrganisationIncludeList.find(:all) #to check the IncludeList is empty or not , in order to disabe the submit and clear button
    end

      if @org_or_person =="person"
      @include_list_all = PersonIncludeList.find(:all) #to check the IncludeList is empty or not , in order to disabe the submit and clear button
    end
    respond_to do |format|
      format.js
    end
  end
end

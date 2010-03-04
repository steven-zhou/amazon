class QueryCriteriasController < ApplicationController
  # System Logging added

  def create
    #------------------------when you click the "Apply the Criteria" , it will come to query_criterias/create action
    #------------------------we do not need to point the orgnisationqueryheader or personqueryheader , cause use id in header table
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    @query_criteria = @query_header.query_criterias.new(params[:query_criteria])
    #-----------------------following set_Data_type in Model, for get the category (eg. integer string Date) set in data_type field of criteria table
    @query_criteria.set_data_type(params[:query_criteria][:field_name], params[:query_criteria][:table_name]) unless params[:query_criteria][:field_name].blank? || params[:query_criteria][:table_name].blank?
    @query_criteria.status = true
    if @query_criteria.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created new Query Criteria #{@query_criteria.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "criteria")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_criteria.errors.on(:table_name).nil? && @query_criteria.errors.on(:table_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "operator") if (!@query_criteria.errors.on(:operator).nil? && @query_criteria.errors.on(:operator).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @query_criteria = QueryCriteria.find(params[:id])
    @query_header = @query_criteria.query_header
    #---------passing the exclude_category value to the view--------------
    @exclude_category = @query_header.class.to_s == "PersonQueryHeader" ? "organisation" : "person"
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @query_criteria = QueryCriteria.find(params[:id].to_i)
    if @query_criteria.update_attributes(params[:query_criteria])
      
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_criteria.errors.on(:table_name).nil? && @query_criteria.errors.on(:table_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "operator") if (!@query_criteria.errors.on(:operator).nil? && @query_criteria.errors.on(:operator).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name).include?("has already been taken"))
    end
    @action = String.new
    @action = params[:current_action]
    @query_header = @query_criteria.query_header
    @query_criteria = QueryCriteria.new
    @exclude_category = @query_header.class.to_s == "PersonQueryHeader" ? "organisation" : "person"
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @query_criteria = QueryCriteria.find(params[:id])
    @query_header = @query_criteria.query_header
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Query Criteria #{@query_criteria.id}.")
    @query_criteria.destroy
    #get current all query criteria to decide if save_button and Run_Query button should be disabled
    @query_criteria_all = QueryCriteria.find(:all, :conditions => {:query_header_id => @query_header.id})
    respond_to do |format|
      format.js
    end
  end
end
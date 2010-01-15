class QueryCriteriasController < ApplicationController
  # System Logging added

  def edit
    @query_criteria = QueryCriteria.find(params[:id])
    @query_header = @query_criteria.query_header
    respond_to do |format|
      format.js
    end
  end
  

  def create
    id = params[:query_header_id]
    id ||= params[:id]
    @query_header = QueryHeader.find(id.to_i)
    @query_criteria = @query_header.query_criterias.new(params[:query_criteria])
    @query_criteria.data_type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:query_criteria][:field_name], TableMetaMetaType.find_by_name(params[:query_criteria][:table_name])]).category
    @query_criteria.status = true
    if @query_criteria.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created new Query Criteria #{@query_criteria.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "criteria")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_criteria.errors.on(:table_name).nil? && @query_criteria.errors.on(:table_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "operator") if (!@query_criteria.errors.on(:operator).nil? && @query_criteria.errors.on(:operator).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @query_criteria = QueryCriteria.find(params[:id].to_i)
    @query_criteria.update_attributes(params[:query_criteria])
    @action = String.new
    @action = params[:current_action]
    @query_header = @query_criteria.query_header
    @query_criteria = QueryCriteria.new
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
#    @query_header = QueryHeader.find(@query_header.id)
#    @query_criteria = QueryCriteria.new
    respond_to do |format|
      format.js
    end
  end
end

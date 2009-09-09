class QueryCriteriasController < ApplicationController

  def edit
    @query_criteria = QueryCriteria.find(params[:id])
    @query_header = @query_criteria.query_header
    respond_to do |format|
      format.js
    end
  end

  def create
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    @query_criteria = @query_header.query_criterias.new(params[:query_criteria])
    @query_criteria.status = true
    if @query_criteria.save
      flash[:message] = flash_message(:type => "object_created_successfully", :object => "criteria")
    else
      flash[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_criteria.errors.on(:table_name).nil? && @query_criteria.errors.on(:table_name)[0] == "can't be blank")
      flash[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_criteria.errors.on(:field_name).nil? && @query_criteria.errors.on(:field_name)[0] == "can't be blank")
      flash[:error] = flash_message(:type => "field_missing", :field => "operator") if (!@query_criteria.errors.on(:operator).nil? && @query_criteria.errors.on(:operator)[0] == "can't be blank")
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @query_criteria = QueryCriteria.find(params[:id])
    @query_criteria.update_attributes(params[:query_criteria])
    @query_header = @query_criteria.query_header
    @query_criteria = QueryCriteria.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @query_criteria = QueryCriteria.find(params[:id])
    @query_header = @query_criteria.query_header
    @query_criteria.destroy
    @query_header = QueryHeader.find(@query_header.id)
    @query_criteria = QueryCriteria.new
    puts "after destroy, #{@query_header.query_criterias.to_yaml}"
    respond_to do |format|
      format.js
    end
  end
end

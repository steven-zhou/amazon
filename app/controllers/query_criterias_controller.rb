class QueryCriteriasController < ApplicationController

  before_filter :check_authentication

  def edit
    
    respond_to do |format|
      format.js
    end
  end

  def create
    @query_criteria = QueryCriteria.new(params[:query_criteria])
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

    respond_to do |format|
      format.js
    end
  end


end

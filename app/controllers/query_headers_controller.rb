class QueryHeadersController < ApplicationController

  def new
    @query_header = QueryHeader.new
    @query_header.name = QueryHeader.random_name
    @query_header.save
    @query_criteria = QueryCriteria.new
    respond_to do |format|
      format.js
    end
  end

  def update
    @query_header = QueryHeader.find(params[:id])
    if !@query_header.query_criterias.blank? && @query_header.update_attributes(params[:query_header])
      @query_header.group = "save"
      @query_header.status = true
      @query_header.save
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "query")
    else
      flash.now[:error] = "save unsuccessfully"
    end
    respond_to do |format|
      format.js
    end
  end


end

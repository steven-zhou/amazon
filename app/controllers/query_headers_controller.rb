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

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
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

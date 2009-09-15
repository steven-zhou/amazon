class QueryHeadersController < ApplicationController

  def new
    @query_header = QueryHeader.new
    @query_header.name = QueryHeader.random_name
    @query_header.save
    @query_criteria = QueryCriteria.new
    @query_seleciton = QuerySelection.new
    @query_sorter = QuerySorter.new
    respond_to do |format|
      format.js
    end
  end

  def update
    @query_header = QueryHeader.find(params[:id].to_i)

    if (!@query_header.query_criterias.empty? && @query_header.update_attributes(params[:query_header]))
      @query_header.group = "save"
      @query_header.status = true if @query_header.status.nil?
      @query_header.save
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "query")
    else
      flash.now[:error] = "save unsuccessfully"
    end
    respond_to do |format|
      format.js
    end
  end

  def show_sql_statement
    @query_header = QueryHeader.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def run
    @query_header = QueryHeader.find(params[:id].to_i)
    @query_header.result_size = @query_header.run.size
    @query_header.save
    @people = @query_header.run
    @list_header = ListHeader.new
    respond_to do |format|
      format.js
    end
  end

  def clear
    @query_header = QueryHeader.find(params[:id].to_i)
    @query_header.query_criterias.each do |c|
      c.destroy
    end
    @query_header.query_criterias.clear

    @query_header.query_selections.each do |s|
      s.destroy
    end
    @query_header.query_selections.clear

    @query_header.query_sorters.each do |s|
      s.destroy
    end
    @query_header.query_sorters.clear
    @query_criteria = QueryCriteria.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @query_header = QueryHeader.find(params[:id].to_i)
    @query_criteria = QueryCriteria.new
    @query_seleciton = QuerySelection.new
    @query_sorter = QuerySorter.new
    respond_to do |format|
      format.js
    end
  end
end

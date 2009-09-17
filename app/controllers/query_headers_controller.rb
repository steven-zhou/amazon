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
    if (!@query_header.query_criterias.empty?)
      if(params[:query_header][:name] == @query_header.name)
        @query_header.update_attributes(params[:query_header])
        @query_header.group = "save"
        @query_header.status = true if @query_header.status.nil?
        @query_header.save
      else
        @query_header_new = Query_header.new(params[:query_header])
        @query_header_new.group = "save"
        @query_header_new.status = true if @query_header.status.nil?
        @query_header_new.save
        @query_header.query_criterias.each do |i|
          @query_criterias.new
        end
      end
      

      
      
      if (params[:new])
        flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "query")
      else        
        flash.now[:message] = flash_message(:type => "object_updated_successfully", :object => "query")
      end
      @query_criteria = QueryCriteria.new
      @query_seleciton = QuerySelection.new
      @query_sorter = QuerySorter.new
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
    @query_header_selected = QueryHeader.find(params[:id].to_i)
    @query_header = QueryHeader.new(@query_header_selected.attributes)
    @query_header.name = @query_header_selected.name + " (Temp #{QueryHeader.random_name})"
    @query_header.group = nil
    @query_header.save

    @query_header_selected.query_criterias.each do |i|
      @query_criteria = QueryCriteria.new(i.attributes)
      @query_criteria.query_header = @query_header
      @query_criteria.save
    end

    @query_header_selected.query_selections.each do |i|
      @query_selection = QuerySelection.new(i.attributes)
      @query_selection.query_header = @query_header
      @query_selection.save
    end

    @query_header_selected.query_sorters.each do |i|
      @query_sorters = QuerySorter.new(i.attributes)
      @query_sorters.query_header = @query_header
      @query_sorters.save
    end

    @query_criteria = QueryCriteria.new
    @query_seleciton = QuerySelection.new
    @query_sorter = QuerySorter.new
    respond_to do |format|
      format.js
    end
  end
end

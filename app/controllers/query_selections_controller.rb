class QuerySelectionsController < ApplicationController

  def create
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    @query_selection = @query_header.query_selections.new(params[:query_selection])
    @query_selection.data_type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:query_selection][:field_name], TableMetaMetaType.find_by_name(params[:query_selection][:table_name])]).category
    @query_selection.status = true
    if @query_selection.save
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "selection")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_selection.errors.on(:table_name).nil? && @query_selection.errors.on(:table_name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_selection.errors.on(:field_name).nil? && @query_selection.errors.on(:field_name)[0] == "can't be blank")
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @query_selection_old = QuerySelection.find(params[:id])
    @query_header = @query_selection_old.query_header
    @query_selection_old.destroy
#    @query_seleciton = QuerySelection.new
#    @query_header = QueryHeader.find(@query_header.id)
    respond_to do |format|
      format.js
    end
  end


end

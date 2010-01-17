class QuerySortersController < ApplicationController
  # System Logging done

  def create
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    @query_sorter = @query_header.query_sorters.new(params[:query_sorter])
    #@query_sorter.data_type = TableMetaType.find(:first, :conditions => ["name = ? AND tag_meta_type_id = ?", params[:query_sorter][:field_name], TableMetaMetaType.find_by_name(params[:query_sorter][:table_name])]).category
    @query_sorter.set_data_type(params[:query_sorter][:field_name],params[:query_sorter][:table_name] )
    @query_sorter.status = true
    if @query_sorter.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Query Sorter #{@query_sorter.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "selection")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_sorter.errors.on(:table_name).nil? && @query_sorter.errors.on(:table_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_sorter.errors.on(:field_name).nil? && @query_sorter.errors.on(:field_name).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @query_sorter_old = QuerySorter.find(params[:id])
    @query_header = @query_sorter_old.query_header
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Query Sorter #{@query_sorter_old.id}.")
    @query_sorter_old.destroy
    respond_to do |format|
      format.js
    end
  end


end

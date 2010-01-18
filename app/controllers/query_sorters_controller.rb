class QuerySortersController < ApplicationController
  # System Logging done

  def create
    #------------------------when you click the "Add attribute" , it will come to query_sorterss/create action
    #------------------------we do not need to point the orgnisationqueryheader or personqueryheader , cause use id in header table
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    @query_sorter = @query_header.query_sorters.new(params[:query_sorter])
    #-----------------------following set_Data_type in Model, for get the category (eg. integer string Date) set in data_type field of criteria table
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

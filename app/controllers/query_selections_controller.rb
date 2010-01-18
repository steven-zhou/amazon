class QuerySelectionsController < ApplicationController
  # System Logging done

  def create
    #------------------------when you click the "Add attribute" , it will come to query_selections/create action
    #------------------------we do not need to point the orgnisationqueryheader or personqueryheader , cause use id in header table
    @query_header = QueryHeader.find(params[:query_header_id].to_i)
    #------------------------we do not accept size > 10
    if @query_header.query_selections.size < 10
      @query_selection = @query_header.query_selections.new(params[:query_selection])
      #-----------------------following set_Data_type in Model, for get the category (eg. integer string Date) set in data_type field of criteria table
      @query_selection.set_data_type(params[:query_selection][:field_name],params[:query_selection][:table_name] )
      @query_selection.status = true
      if @query_selection.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Query Selection #{@query_selection.id}.")
        flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "selection")
      else
        flash.now[:error] = flash_message(:type => "field_missing", :field => "table_name") if (!@query_selection.errors.on(:table_name).nil? && @query_selection.errors.on(:table_name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "field_name") if (!@query_selection.errors.on(:field_name).nil? && @query_selection.errors.on(:field_name).include?("can't be blank"))
      end
    else
      flash.now[:error] = "Only Display Ten Attributes"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @query_selection_old = QuerySelection.find(params[:id])
    @query_header = @query_selection_old.query_header 
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Query Selection #{@query_selection_old.id}.")
    @query_selection_old.destroy
    respond_to do |format|
      format.js
    end
  end


end

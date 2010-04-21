class DataManagersController < ApplicationController
  # System logging also done here...


  include OutputPdf

  def import_index
    respond_to do |format|
      format.html
    end
  end

  def export_index
    @queries = PersonQueryHeader.saved_queries
    @lists = @current_user.all_person_lists
    @org_queries = OrganisationQueryHeader.saved_queries
    @org_lists = @current_user.all_organisation_lists
    respond_to do |format|
      format.html
    end
  end

  def check_runtime
    @format = params[:export_format]
    @source = params[:source]
    @source_id = params[:source_id]
    @file_name = params[:file_name]
    @id = @source_id.delete("query_")
    #check runtime for query only
    @query_header = QueryHeader.find(@id.to_i)

    @runtime = false
    @query_header.query_criterias.each do |i|
      if i.value == "?"
        @runtime = true
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def copy_runtime
    @format = params[:export_format]
    @source = params[:source]
    @source_id = params[:source_id]
    @file_name = params[:file_name]
      
    @query_header_old = QueryHeader.find(params[:id].to_i)
    @query_header_new = @query_header_old.class.new
    @query_header_new.name = QueryHeader.random_name
    @query_header_new.group = "temp"
    @query_header_new.status = true
    @query_header_new.save
    @query_header_old.query_criterias.each do |i|
      @query_criteria = QueryCriteria.new(i.attributes)
      if @query_criteria.value == "?"
        @query_criteria.value = params[@query_criteria.table_name.to_sym][@query_criteria.field_name.to_sym]
      end
      @query_criteria.query_header_id = @query_header_new.id
      @query_criteria.save
    end

    @query_header_old.query_selections.each do |i|
      @query_selection = QuerySelection.new(i.attributes)
      @query_selection.query_header_id = @query_header_new.id
      @query_selection.save
    end

    @query_header_old.query_sorters.each do |i|
      @query_sorter = QuerySorter.new(i.attributes)
      @query_sorter.query_header_id = @query_header_new.id
      @query_sorter.save
    end
    
    #use new query header (copyed one) to export
    @source_id = "query_#{@query_header_new.id}"
    render 'check_runtime.js'
  end

  def export
    @source_id = String.new
    @source_type = String.new
    if(params[:source]=="person")
      find_people_to_export
      @entity_type = "person"
    else
      # Export Organisations
      find_organsiations_to_export
      @entity_type = "organisation"
    end

    @file_name = params[:file_name].blank? ? "export" : params[:file_name]
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) exported a report.")

    respond_to do |format|
      format.html { render_html }
      format.xml { render_xml}
      format.csv {send_data( (render_html ), :filename => "#{@file_name}.csv", :type => "text/csv")}
      format.pdf {pdf = PDF::Writer.new
        pdf = generate_pdf
        send_data(pdf.render, :filename => "#{@file_name}.pdf", :type => "application/pdf")}
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if @field == "person_part"
      @queries = PersonQueryHeader.saved_queries
      @lists = @current_user.all_person_lists
    else
      @org_queries = OrganisationQueryHeader.saved_queries
      @org_lists = @current_user.all_organisation_lists
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def render_xml
    if @entity_type == "person"
      send_data((render 'data_managers/export.rxml'), :filename => "#{@file_name}.xml", :type => "text/xml")
    else   
      send_data((render 'data_managers/org_export.rxml'), :filename => "#{@file_name}.xml", :type => "text/xml")
    end
  end

  def render_html
    if @entity_type == "person"
      render 'data_managers/export.html'
    else
      render 'data_managers/org_export.html'
    end
  end

  def generate_pdf
    if @entity_type == "person"
      OutputPdf.generate_pdf(@source_type, @source_id, {}, {})
    else
      OutputPdf.generate_org_pdf(@source_type, @source_id, {}, {})
    end
  end


  def find_people_to_export
    if(params[:source_id].include?("query_"))
      @source_id = params[:source_id].delete("query_")
      @source_type = "query"
      @query_header = QueryHeader.find(@source_id)
      @entities = @query_header.run
    else
      @source_id = params[:source_id].delete("list_")
      @source_type = "list"
      @entities = ListHeader.find(@source_id).entity_on_list

    end
  end
  def find_organsiations_to_export
    if(params[:source_id].include?("query_"))
      @source_id = params[:source_id].delete("query_")
      @source_type = "query"
      @query_header = QueryHeader.find(@source_id)
      @entities = @query_header.run
    else
      @source_id = params[:source_id].delete("list_")
      @source_type = "list"
      @entities = ListHeader.find(@source_id).entity_on_list
    end
  end

end

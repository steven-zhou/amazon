class DataManagersController < ApplicationController
  # System logging also done here...


  include OutputPdf

  def import_index
    respond_to do |format|
      format.html
    end
  end

  def export_index
    @queries = QueryHeader.saved_queries
    @lists = ListHeader.all
    respond_to do |format|
      format.html
    end
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
      format.html {
        if @entity_type == "person"
          render 'data_managers/export.html'
        else
          render 'data_managers/org_export.html'
        end
      }

      format.xml {send_data((render 'data_managers/export.rxml'), :filename => "#{@file_name}.xml", :type => "text/xml")}
      format.csv {send_data((render 'data_managers/export.html'), :filename => "#{@file_name}.csv", :type => "text/csv")}
      format.pdf {pdf = PDF::Writer.new
        pdf = OutputPdf.generate_pdf(@source_type, @source_id, {}, {})
        send_data(pdf.render, :filename => "#{@file_name}.pdf", :type => "application/pdf")}
    end
  end

  private

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

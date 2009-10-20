class DataManagersController < ApplicationController

  require "pdf/writer"
  require "pdf/simpletable"

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
    @type = String.new
    if(params[:source]=="person")
      if(params[:source_id].include?("query_"))
        @source_id = params[:source_id].delete("query_")
        @type = "Query"
        @query_header = QueryHeader.find(@source_id)
        @people = @query_header.run
      else
        @source_id = params[:source_id].delete("list_")
        @type = "List"
        @people = ListHeader.find(@source_id).people_on_list
      end
    else
#      Export Organisations
    end

    respond_to do |format|
      format.html {render 'data_managers/export.html'}
      format.pdf {send_data(pdf.render, :filename => "report.pdf", :type => "application/pdf")}
      format.xml {send_data((render 'data_managers/export.rxml'), :filename => "export.xml", :type => "text/xml")}
      format.csv {send_data((render 'data_managers/export.html'), :filename => "export.csv", :type => "text/csv")}
    end
  end

end

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
      if(params[:source_id].include?("query_"))
        @source_id = params[:source_id].delete("query_")
        @source_type = "query"
        @query_header = QueryHeader.find(@source_id)
        @people = @query_header.run
      else
        @source_id = params[:source_id].delete("list_")
        @source_type = "list"
        @people = ListHeader.find(@source_id).people_on_list
      end
    else
#      Export Organisations
    end

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) exported a report.")

    respond_to do |format|
      format.html {render 'data_managers/export.html'}      
      format.xml {send_data((render 'data_managers/export.rxml'), :filename => "export.xml", :type => "text/xml")}
      format.csv {send_data((render 'data_managers/export.html'), :filename => "export.csv", :type => "text/csv")}
      format.pdf {pdf = PDF::Writer.new
                  pdf = OutputPdf.generate_pdf(@source_type, @source_id, {}, {})
                  send_data(pdf.render, :filename => "report.pdf", :type => "application/pdf")}
    end
  end

end

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
      format.html { render_html }


      format.xml {
        if @entity_type == "person"
          send_data((render 'data_managers/export.rxml'), :filename => "#{@file_name}.xml", :type => "text/xml")
        else
          send_data((render 'data_managers/org_export.rxml'), :filename => "#{@file_name}.xml", :type => "text/xml")
        end


      }
      format.csv {send_data((render 'data_managers/export.html'), :filename => "#{@file_name}.csv", :type => "text/csv")}
      format.pdf {pdf = PDF::Writer.new
        pdf = OutputPdf.generate_pdf(@source_type, @source_id, {}, {})
        send_data(pdf.render, :filename => "#{@file_name}.pdf", :type => "application/pdf")}
    end
  end


  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @queries = PersonQueryHeader.saved_queries
    @lists = ListHeader.all
    respond_to do |format|
      format.js
    end
  end


  private
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

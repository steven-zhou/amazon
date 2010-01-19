class ReportsController < ApplicationController
  # System Logging done.

  require "pdf/writer"
  require "pdf/simpletable"
  include OutputPdf

  def index

    @list_headers = @current_user.all_person_lists
    @query = PersonQueryHeader.saved_queries
    @org_queries = OrganisationQueryHeader.saved_queries
    @org_lists = @current_user.all_organisation_lists

  end

  def preview_report

    @person_report_format = params[:report][:requested_format]

    @person_report_list = ListHeader.find(params[:list_header_id].to_i)
    PersonContactsReportGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end


    @person_report_list.list_details.each do |i|
      @pcr = PersonContactsReportGrid.new # person contacts report
      @pcr.login_account_id = session[:user]
      @person = Person.find(i.person_id)
      @pcr.grid_object_id = i.id
      @pcr.field_1 = @person.first_name
      @pcr.field_2 = @person.family_name
      @pcr.save
    end

    render 'person_contacts_report_grid.js'
  end

  def person_contacts_report_grid
    @person_report_format = params[:request_format]


    if(params[:list_header_id].include?("list_"))
      @list_header_id = params[:list_header_id].delete("list_")
     
      
      @type= "List"
      @person_report_list = ListHeader.find(@list_header_id)
    end
   
    PersonContactsReportGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end
    if(@person_report_format == "Contact Report")
       
      @person_report_list.list_details.each do |i|
        @pcr = PersonContactsReportGrid.new # person contacts report
        @pcr.login_account_id = session[:user]
        @person = Person.find(i.person_id)
        @pcr.grid_object_id = i.id
        @pcr.field_1 = @person.first_name
        @pcr.field_2 = @person.family_name
        @pcr.field_3 = @person.primary_email.address unless @person.primary_email.blank?
        if (!(@person.secondary_email.blank?))
          @pcr.field_3+="<br>"+ @person.secondary_email.address
        end
     
        @pcr.field_4 = @person.primary_phone.value unless @person.primary_phone.blank?
        if (!(@person.secondary_phone.blank?))
          @pcr.field_4+="<br>"+ @person.secondary_phone.value
        end

        @pcr.field_5 = @person.primary_website.value unless @person.primary_website.blank?
        if (!(@person.secondary_website.blank?))
          @pcr.field_5+="<br>"+ @person.secondary_website.value
        end

        @pcr.field_6 = @person.primary_address.first_line unless @person.primary_address.blank?
        if (!(@person.primary_address.blank?))
          @pcr.field_6+="<br>"+ @person.primary_address.second_line
        end

        
        @pcr.save
      end
    end

    respond_to do |format|
      format.js
    end

  end

  def generate_person_report_pdf
    #     @person_report_format = params[:request_format]
    @person_report_format ="person_contact_report"
    if(params[:list_header_id].include?("list_"))
     
      @list_header_id = params[:list_header_id].delete("list_")
      @type= "list"
      @list_name = "List "+ListHeader.find(@list_header_id).name
      @person_report_list = ListHeader.find(@list_header_id).entity_on_list
    end

    if(params[:list_header_id].include?("query_"))  

      @list_header_id = params[:list_header_id].delete("query_")
      @type= "query"
      @list_name = "Query "+ListHeader.find(@list_header_id).name
      @person_report_list = ListHeader.find(@list_header_id).entity_on_list
    end
    
    if OutputPdf.personal_report_format_valid(@person_report_format) && !@person_report_list.nil?
      pdf = OutputPdf.generate_personal_report_pdf(@type,@list_header_id, @person_report_format,@list_name)
     
    end

    respond_to do |format|
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) generated a Person Report PDF.")
      format.pdf {send_data(pdf.render, :filename => "person_report.pdf", :type => "application/pdf")}
    end


  end

  def generate_organisation_report_pdf
    @organisation_report_list = Organisation.find(:all, :conditions => ["type != ?", "ClientOrganisation"], :order => "id")
    @type ="List"
    @organisation_report_format = "organisaiton_contact_report"

    if OutputPdf.organisational_report_format_valid(@organisation_report_format) && !@organisation_report_list.nil?

      pdf = OutputPdf.generate_organisational_report_pdf(@type,@organisation_report_list, @organisation_report_format)

    end

    respond_to do |format|
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) generated an Organisation Report PDF.")
      format.pdf {send_data(pdf.render, :filename => "organisation_report.pdf", :type => "application/pdf")}
    end

  end

  def generate_system_log_pdf
    user_name = ((!params[:user_name].nil? && !params[:user_name].empty?) ? params[:user_name] : '%%')
    start_date = ((!params[:start_date].nil? && !params[:start_date].empty?) ? params[:start_date].to_date.strftime('%Y-%m-%d') : '0001-01-01 00:00:01')
    end_date = ((!params[:end_date].nil? && !params[:end_date].empty?) ? params[:end_date].to_date.strftime('%Y-%m-%d') : '9999-12-31 23:59:59')
    controller = ((!params[:log_controller].nil? && !params[:log_controller].empty?) ? params[:log_controller] : '%%')
    action = ((!params[:log_action].nil? && !params[:log_action].empty?) ? params[:log_action] : '%%')
    status = ((!params[:status].nil? && !params[:status].empty?) ? params[:status] : '%%')
    @system_log_entries = SystemLog.find_by_sql(["SELECT s.id AS \"id\", s.created_at AS \"created_at\", s.login_account_id AS \"login_account_id\", s.ip_address AS \"ip_address\", s.controller AS \"controller\", s.action AS \"action\", s.message AS \"message\" FROM system_logs s, login_accounts l WHERE s.login_account_id = l.id AND l.user_name LIKE ? AND s.created_at >= ? AND s.created_at <= ? AND s.status LIKE ? ORDER BY s.id ASC", user_name, start_date, end_date, status])
    @type = "System Log Report"
    @report_format = "system_log_report"


    if OutputPdf.system_log_report_format_valid(@report_format) && !@system_log_entries.nil?
      pdf = OutputPdf.generate_system_log_report_pdf(@type,@system_log_entries, @report_format)
    end

    respond_to do |format|
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) generated a System Log PDF.")
      format.pdf {send_data(pdf.render, :filename => "system_log_report.pdf", :type => "application/pdf")}
    end


  end


  def organisation_contacts_report_grid

    @organisation_report_format = params[:request_format]

    @organisation_report_list = Organisation.find(:all, :conditions => ["type != ?", "ClientOrganisation"], :order => "id")

    if(@organisation_report_format == "Contact Report")

      OgansisationContactsReportGrid.find_all_by_login_account_id(session[:user]).each do |i|
        i.destroy
      end

      @organisation_report_list.each do |o|
        @ocr = OgansisationContactsReportGrid.new #oganisation contact report
        @ocr.login_account_id = session[:user]
        @ocr.grid_object_id = o.id
        @ocr.field_1 = o.full_name
        @ocr.field_2 = o.registered_name
        @ocr.field_3 = o.primary_email.address unless o.primary_email.blank?
        #      @ocr.field_3 = o.primary_address.first_line unless o.primary_address.blank?
        #      @ocr.field_4 = o.primary_phone.value unless o.primary_phone.blank?
        #      @ocr.field_5 = o.primary_email.address unless o.primary_email.blank?
        if (!(o.secondary_email.blank?))
          @ocr.field_3+="<br>"+ o.secondary_email.address
        end
        @ocr.field_4 = o.primary_phone.value unless o.primary_phone.blank?
        if (!(o.secondary_phone.blank?))
          @ocr.field_4+="<br>"+ o.secondary_phone.value
        end
        @ocr.field_5 = o.primary_website.value unless o.primary_website.blank?
        if (!(o.secondary_website.blank?))
          @ocr.field_5+="<br>"+ o.secondary_website.value
        end
        @ocr.field_6 = o.primary_address.first_line unless o.primary_address.blank?
        if (!(o.primary_address.blank?))
          @ocr.field_6+="<br>"+ o.primary_address.second_line
        end

        @ocr.save
      end
    end
    respond_to do |format|
      format.js
    end

      
  end


  #  def generate_report
  #
  #    report_format = params[:report][:requested_format]
  #    report_list = ListHeader.find_by_id(params[:list_header_id].to_i)
  #
  #    if !report_format_valid(report_format) || report_list.nil?
  #      flash[:error] = flash_message(:type => "field_missing", :field => "report list") if report_list.nil?
  #      flash[:error] = flash_message(:message => "There was an error generating a report in the format you specified.") if !report_format_valid(report_format)
  #      redirect_to :action => "create", :controller => "reports"
  #    else
  #      pdf = PDF::Writer.new
  #      generate_header(pdf, report_format)
  #      generate_body(pdf, report_format, report_list)
  #      send_data pdf.render, :filename => "#{report_format}.pdf", :type => "application/pdf"
  #
  #    end
  #
  #  end

  private

  #  def report_format_valid(report_format)
  #    [
  #      "Contact Report",
  #      "System Log Report"
  #    ].include?(report_format.to_s)
  #
  #  end
  #
  #  def generate_header(pdf, report_format)
  #    pdf.image "#{RAILS_ROOT}/public/images/Amazon-logo.jpg", :justification => :left
  #    pdf.select_font "Times-Roman"
  #    pdf.text "#{report_format}\n\n", :font_size => 32, :justification => :center
  #
  #
  #  end
  #
  #  def generate_body(pdf, report_format, report_list)
  #
  #    if report_list.entity_on_list.empty?
  #      pdf.text "No matching records found.", :font_size => 32, :justification => :center
  #      return
  #    end
  #
  #    case report_format.to_s
  #
  #    when "Contact Report"
  #
  #
  #      PDF::SimpleTable.new do |tab|
  #
  #
  #        tab.column_order.push(*%w(system_id name email phone website))
  #
  #        tab.columns["system_id"] = PDF::SimpleTable::Column.new("system_id") { |col|
  #          col.heading = "ID"
  #        }
  #
  #        tab.columns["name"] = PDF::SimpleTable::Column.new("name") { |col|
  #          col.heading = "Name"
  #        }
  #
  #        tab.columns["email"] = PDF::SimpleTable::Column.new("email") { |col|
  #          col.heading = "Email"
  #        }
  #
  #        tab.columns["phone"] = PDF::SimpleTable::Column.new("phone") { |col|
  #          col.heading = "Phone"
  #        }
  #
  #        tab.columns["website"] = PDF::SimpleTable::Column.new("website") { |col|
  #          col.heading = "Website"
  #        }
  #
  #
  #        tab.show_lines    = :outer
  #        tab.show_headings = true
  #        tab.orientation   = :center
  #        tab.position      = :center
  #        tab.bold_headings = false
  #
  #        data = Array.new
  #
  #        for person in report_list.entity_on_list do
  #
  #          email = format_fields(person.primary_email, person.secondary_email)
  #          phone = format_fields(person.primary_phone, person.secondary_phone)
  #          website = person.primary_website
  #
  #          data << { "system_id" => "#{person.id}", "name" => "#{person.name}", "email" => "#{email}", "phone" => "#{phone}", "website" => "#{website}" }
  #
  #        end
  #
  #        tab.data.replace data
  #        tab.render_on(pdf)
  #      end
  #
  #    end
  #
  #  end

 
  

  private

  def format_email(email)
    return "" if email.nil?
    return email.value
  end

  def format_phone(phone)
    return "" if phone.nil?
    result = phone.complete_number
    result += " (#{phone.contact_meta_type.category})" unless phone.contact_meta_type.category.nil?
    return result
  end

  def format_website(website)
    return "" if website.nil?
    result = website.value
    result += " (#{website.contact_meta_type.category})" unless website.contact_meta_type.category.nil?
    return result
  end

  def format_fields(field_one, field_two)
    if field_two.nil?
      return field_one
    else
      return "#{field_one}\n#{field_two}"
    end
  end

end

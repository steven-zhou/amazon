class ReportsController < ApplicationController

  require "pdf/writer"
  require "pdf/simpletable"


  def index
    @list_headers = @current_user.list_headers
  end

  def preview_report
    #    @report_format = params[:report][:requested_format]
    #    @report_list = ListHeader.find_by_id(params[:list_header_id].to_i)

    #    if !report_format_valid(@report_format) || @report_list.nil?
    #      flash[:error] = flash_message(:type => "field_missing", :field => "report list") if @report_list.nil?
    #      flash[:error] = flash_message(:message => "There was an error generating a report in the format you specified.") if !report_format_valid(@report_format)
    #      redirect_to :action => "create", :controller => "reports"
    #    else
    #      # Do nothing, render the page...
    #    end

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
      #        @pcr.field_3 = @person.primary_address.first_line unless i.primary_address.blank?
      #        @pcr.field_4 = @person.primary_phone.value unless i.primary_phone.blank?
      #        @pcr.field_5 = @person.primary_email.address unless i.primary_email.blank?
      @pcr.save
    end

    render 'person_contacts_report_grid.js'
  end

  def person_contacts_report_grid
    @person_report_format = params[:request_format]

    @person_report_list = ListHeader.find(params[:list_header_id].to_i)

    if(@person_report_format == "Contact Report")

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



  def generate_report

    report_format = params[:report][:requested_format]
    report_list = ListHeader.find_by_id(params[:list_header_id].to_i)

    if !report_format_valid(report_format) || report_list.nil?
      flash[:error] = flash_message(:type => "field_missing", :field => "report list") if report_list.nil?
      flash[:error] = flash_message(:message => "There was an error generating a report in the format you specified.") if !report_format_valid(report_format)
      redirect_to :action => "create", :controller => "reports"
    else
      pdf = PDF::Writer.new
      generate_header(pdf, report_format)
      generate_body(pdf, report_format, report_list)
      send_data pdf.render, :filename => "#{report_format}.pdf", :type => "application/pdf"

    end

  end

  private

  def report_format_valid(report_format)
    [
      "Contact Report"
    ].include?(report_format.to_s)

  end

  def generate_header(pdf, report_format)
    pdf.image "#{RAILS_ROOT}/public/images/Amazon-logo.jpg", :justification => :left
    pdf.select_font "Times-Roman"
    pdf.text "#{report_format}\n\n", :font_size => 32, :justification => :center


  end

  def generate_body(pdf, report_format, report_list)

    if report_list.people_on_list.empty?
      pdf.text "No matching records found.", :font_size => 32, :justification => :center
      return
    end

    case report_format.to_s

    when "Contact Report"


      PDF::SimpleTable.new do |tab|


        tab.column_order.push(*%w(system_id name email phone website))

        tab.columns["system_id"] = PDF::SimpleTable::Column.new("system_id") { |col|
          col.heading = "ID"
        }

        tab.columns["name"] = PDF::SimpleTable::Column.new("name") { |col|
          col.heading = "Name"
        }

        tab.columns["email"] = PDF::SimpleTable::Column.new("email") { |col|
          col.heading = "Email"
        }

        tab.columns["phone"] = PDF::SimpleTable::Column.new("phone") { |col|
          col.heading = "Phone"
        }

        tab.columns["website"] = PDF::SimpleTable::Column.new("website") { |col|
          col.heading = "Website"
        }


        tab.show_lines    = :outer
        tab.show_headings = true
        tab.orientation   = :center
        tab.position      = :center
        tab.bold_headings = false

        data = Array.new

        for person in report_list.people_on_list do
          
          email = format_fields(person.primary_email, person.secondary_email)
          phone = format_fields(person.primary_phone, person.secondary_phone)
          website = person.primary_website

          data << { "system_id" => "#{person.id}", "name" => "#{person.name}", "email" => "#{email}", "phone" => "#{phone}", "website" => "#{website}" }

        end

        tab.data.replace data
        tab.render_on(pdf)
      end

    end

  end

 
  

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
    if field_two.empty?
      return field_one
    else
      return "#{field_one}\n#{field_two}"
    end
  end

end

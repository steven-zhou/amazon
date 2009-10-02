class ReportsController < ApplicationController

  require "pdf/writer"
  require "pdf/simpletable"


  def index
    @list_headers = @current_user.list_headers
  end

  def preview_report
    @report_format = params[:report][:requested_format]
    @report_list = ListHeader.find_by_id(params[:list_header_id].to_i)

    if !report_format_valid(@report_format) || @report_list.nil?
      flash[:error] = flash_message(:type => "field_missing", :field => "report list") if @report_list.nil?
      flash[:error] = flash_message(:message => "There was an error generating a report in the format you specified.") if !report_format_valid(@report_format)
      redirect_to :action => "create", :controller => "reports"
    else
      # Do nothing, render the page...
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
          
          email_one = format_email(person.emails.select{ |email| email.priority_number == 1}.first)
          email_two = format_email(person.emails.select{ |email| email.priority_number == 2}.first)
          phone_one = format_phone(person.phones.select{ |phone| phone.priority_number == 1}.first)
          phone_two = format_phone(person.phones.select{ |phone| phone.priority_number == 2}.first)
          website_one = format_website(person.websites.select{ |website| website.priority_number == 1}.first)
          website_two = format_website(person.websites.select{ |website| website.priority_number == 2}.first)

          email = format_fields(email_one, email_two)
          phone = format_fields(phone_one, phone_two)
          website = format_fields(website_one, website_two)

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

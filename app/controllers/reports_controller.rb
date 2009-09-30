class ReportsController < ApplicationController

  require "pdf/writer"
  require "pdf/simpletable"


  def index
    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = Array.new
    c = Array.new
    @group_types.each do |group_type|
      a = group_type.list_headers
      c += a
      @list_headers = c.uniq
    end
  end

  def generate_report

    report_format = params[:report][:format]
    report_name = params[:report][:name]
    report_list = ListHeader.find_by_id(params[:list_header_id].to_i)

    if report_name.blank? || !report_format_valid(report_format) || report_list.nil?
      flash[:error] = flash_message(:type => "field_missing", :field => "name") if report_name.blank?
      flash[:error] = flash_message(:type => "field_missing", :field => "report list") if report_list.nil?
      flash[:error] = flash_message(:message => "There was an error generating a report in the format you specified.") if !report_format_valid(report_format)
      redirect_to :action => "create", :controller => "reports"
    else
      pdf = PDF::Writer.new
      generate_header(pdf, report_name)
      generate_body(pdf, report_format, report_list)
      send_data pdf.render, :filename => "#{report_name}_report.pdf", :type => "application/pdf"

    end

  end

  private

  def report_format_valid(report_format)
    [
      "Contact Report"
    ].include?(report_format.to_s)

  end

  def generate_header(pdf, report_name)
    pdf.image "#{RAILS_ROOT}/public/images/Amazon-logo.jpg", :justification => :left
    pdf.select_font "Times-Roman"
    pdf.text "#{report_name}\n\n", :font_size => 32, :justification => :center


  end

  def generate_body(pdf, report_format, report_list)

    if report_list.people_on_list.empty?
      pdf.text "No matching records found.", :font_size => 32, :justification => :center
      return
    end

    case report_format.to_s

    when "Contact Report"


      PDF::SimpleTable.new do |tab|


        tab.column_order.push(*%w(system_id name email phone website fax))

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

        tab.columns["fax"] = PDF::SimpleTable::Column.new("fax") { |col|
          col.heading = "Fax"
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
          fax_one = format_fax(person.faxes.select{ |fax| fax.priority_number == 1}.first)
          fax_two = format_fax(person.faxes.select{ |fax| fax.priority_number == 2}.first)

          data << { "system_id" => "#{person.id}", "name" => "#{person.name}", "email" => "#{email_one}", "phone" => "#{phone_one}", "website" => "#{website_one}", "fax" => "#{fax_one}" }

          if (!email_two.empty? || !phone_two.empty? || !website_two.empty? || !fax_two.empty?)
            data << { "system_id" => "", "name" => "", "email" => "#{email_two}", "phone" => "#{phone_two}", "website" => "#{website_two}", "fax" => "#{fax_two}" }          
          end

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
    phone.complete_number
  end

  def format_fax(fax)
    return "" if fax.nil?
    fax.complete_number
  end

  def format_website(website)
    return "" if website.nil?
    website.value
  end

end

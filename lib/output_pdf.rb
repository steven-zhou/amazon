module OutputPdf

  FORMAT = {"person_contact_report" => {"ID" => "id",
                                        "First Name" => "first_name",
                                        "Family Name" => "family_name",
                                        "Address" => "address",
                                        "Email" => "email",
                                        "Phone" => "phone",
                                        "Website" => "website"},
                                      
            "organisaiton_contact_report" => {"ID" => "id",
                                              "Full Name" => "first_name",
                                              "Registered Name" => "family_name",
                                              "Address" => "address",
                                              "Email" => "email",
                                              "Phone" => "phone",
                                              "Website" => "website"}
  }

  #  format only valid for report, it does not apply to query
  def pdf_format_valid(format)
    OutputPdf::FORMAT.has_key?(format.to_s)
  end

  def generate_pdf(source_type, source_id, format, image, title, header_settings, body_settings)
    pdf = PDF::Writer.new
    generate_header(pdf, source_type, source_id, format, image, title, header_settings)
    generate_body(pdf, source_type, source_id, format, body_settings)
    return pdf
  end

  

  def generate_header(pdf, source_type, source_id, format, image, title, header_settings)
    #default setting for pdf header
    image ||= "#{RAILS_ROOT}/public/images/Amazon-logo.jpg"
    if format
      title ||= "Report from #{source_type}_#{source_id}"
    else
      title ||= "#{source_type}_#{source_id}"
    end
    header_settings[:image_align] ||= "left"
    header_settings[:title_align] ||= "center"
    header_settings[:font] ||= "Times-Roman"
    header_settings[:font_size] ||= 32


    pdf.image image, :justification => header_settings[:image_align]
    pdf.select_font header_settings[:font]
    pdf.text "#{title}\n\n", :font_size => header_settings[:font_size], :justification => header_settings[:title_align]
  end

  def generate_body(pdf, source_type, source_id, format, body_settings)
    body_settings[:show_lines] ||= "outer"
    body_settings[:show_headings] ||= true
    body_settings[:orientation] ||= "center"
    body_settings[:position] ||= "center"
    body_settings[:bold_header] ||= false


    if source_type == "query"
      #query
      @people = QueryHeader.find(source_id).run
    else
      #list
      @people = ListHeader.find(source_id).people_on_list
    end

    if @people.empty?
      pdf.text "No matching records found.", :font_size => 32, :justification => :center
      return
    end

    
    if format
      #report
        PDF::SimpleTable.new do |tab|
          OutputPdf::FORMAT[format].each do |i|
            tab.column_order.push(OutputPdf::FORMAT[format][i])
          end
          
          OutputPdf::FORMAT[format].each do |i|
            tab.column[OutputPdf::FORMAT[format][i]] = PDF::SimpleTable::Column.new(OutputPdf::FORMAT[format][i]) 
          end

        end
    else
      #not report

    end

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

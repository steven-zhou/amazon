module OutputPdf

  require "pdf/writer"
  require "pdf/simpletable"
  
  # if the field is FK(e.g. gender), the hash would be "Gender(FK)" => "gender"
  PERSONAL_REPORT_FORMAT = {"person_contact_report" => {"id" => "id",
      "first_name" => "first_name",
      "family_name" => "family_name",
      "address" => "address",
      "email" => "email",
      "phone" => "phone",
      "website" => "website"}}
  
  ORGANISATIONAL_REPORT_FORMAT = {"organisaiton_contact_report" => {"ID" => "id",
      "Full Name" => "first_name",
      "Registered Name" => "family_name",
      "Address" => "address",
      "Email" => "email",
      "Phone" => "phone",
      "Website" => "website"}}

  PERSON_DEFAULT_FORMAT = {"id" => "id", "address" => "address",
    "email" => "email", "phone" => "phone", "website" => "website"}
                          

  # The difference between report and non_report is with/without format
  # validate personal report format
  def self.personal_report_format_valid(format)
    OutputPdf::PERSONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  # validate personal report format
  def self.organisational_report_format_valid(format)
    OutputPdf::ORGANISATIONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  #  generate personal report in pdf
  # private method - generate_personal_report_pdf
  # geneare_personal_report_pdf(source_type, source_id, format, header_settings={}, body_settings={})
  # options in header_settings:
  #       image(image)                      = path of image
  #       title(report title)               = string(e.g. "Person Contact Report")
  #       image_position(position of image) = "left"/"center"/"right"
  #       title_position(position of title) = "left"/"center"/"right"
  #       font(font)                        = any font(e.g. "Times-Roman)
  #       font_size(font_size)              = any integer(e.g. 32)
  # options in body_settings:
  #       show_lines(position of lines)     = "outer"/"inner"
  #       show_headings(display or not)     = true/false
  #       orientation(orientation)          = "left"/"center"/"right"
  #       position(position)                = "left"/"center"/"right"
  #       bold_header(header bold?)         = true/false
  #       font_size(font_size)              = any integer(e.g. 32)
  #       text_align(alignment)             = "left"/"center"/"right"
  def self.generate_personal_report_pdf(source_type, source_id, format, header_settings={}, body_settings={})
    pdf = PDF::Writer.new
    generate_report_header(pdf, source_type, source_id, format, header_settings)
    generate_personal_report_body(pdf, source_type, source_id, format, body_settings)
    return pdf
  end

  # generate organisational report in pdf
  # private method - generate_organisational_report_pdf
  # geneare_personal_report_pdf(source_type, source_id, format, header_settings={}, body_settings={})
  # options in header_settings:
  #       image(image)                      = path of image
  #       title(report title)               = string(e.g. "Person Contact Report")
  #       image_position(position of image) = "left"/"center"/"right"
  #       title_position(position of title) = "left"/"center"/"right"
  #       font(font)                        = any font(e.g. "Times-Roman)
  #       font_size(font_size)              = any integer(e.g. 32)
  # options in body_settings:
  #       show_lines(position of lines)     = "outer"/"inner"
  #       show_headings(display or not)     = true/false
  #       orientation(orientation)          = "left"/"center"/"right"
  #       position(position)                = "left"/"center"/"right"
  #       bold_header(header bold?)         = true/false
  #       font_size(font_size)              = any integer(e.g. 32)
  #       text_align(alignment)             = "left"/"center"/"right"
  def self.generate_organisational_report_pdf(source_type, source_id, format, header_settings={}, body_settings={})
    pdf = PDF::Writer.new
    generate_report_header(pdf, source_type, source_id, format, header_settings)
    generate_organisational_report_body(pdf, source_type, source_id, format, body_settings)
    return pdf
  end

  # generate pdf from source (non_report)
  # private method - generate_pdf
  # geneare_pdf(source_type, source_id, header_settings={}, body_settings={})
  # options in header_settings:
  #       image(image)                      = path of image
  #       title(report title)               = string(e.g. "Person Contact Report")
  #       image_position(position of image) = "left"/"center"/"right"
  #       title_position(position of title) = "left"/"center"/"right"
  #       font(font)                        = any font(e.g. "Times-Roman)
  #       font_size(font_size)              = any integer(e.g. 32)
  # options in body_settings:
  #       show_lines(position of lines)     = "outer"/"inner"
  #       show_headings(display or not)     = true/false
  #       orientation(orientation)          = "left"/"center"/"right"
  #       position(position)                = "left"/"center"/"right"
  #       bold_header(header bold?)         = true/false
  #       font_size(font_size)              = any integer(e.g. 32)
  #       text_align(alignment)             = "left"/"center"/"right"
  def self.generate_pdf(source_type, source_id, header_settings={}, body_settings={})
    pdf = PDF::Writer.new
    generate_header(pdf, source_type, source_id, header_settings)
    generate_body(pdf, source_type, source_id, body_settings)
    return pdf
  end


  private

 
  # private method - generate_report_header
  # geneare_report_header(pdf, source_type, source_id, format, header_settings={})
  # options in header_settings:
  #       image(image)                      = path of image
  #       title(report title)               = string(e.g. "Person Contact Report")
  #       image_position(position of image) = "left"/"center"/"right"
  #       title_position(position of title) = "left"/"center"/"right"
  #       font(font)                     = any font(e.g. "Times-Roman)
  #       font_size(font_size)           = any integer(e.g. 32)
  def self.generate_report_header(pdf, source_type, source_id, format, header_settings={})
    #default setting for pdf header
    header_settings[:image] ||= "#{RAILS_ROOT}/public/images/Amazon-logo.jpg"
    header_settings[:title] ||= "#{format} from #{source_type}_#{source_id}"
    header_settings[:image_position] ||= "left"
    header_settings[:title_position] ||= "center"
    header_settings[:font] ||= "Times-Roman"
    header_settings[:font_size] ||= 32


    pdf.image header_settings[:image], :justification => header_settings[:image_position]
    pdf.select_font header_settings[:font]
    pdf.text "#{header_settings[:title]}\n\n", :font_size => header_settings[:font_size], :justification => header_settings[:title_position]
  end

  # private method - generate_personal_report_body
  # geneare_personal_report_body(pdf, source_type, source_id, format, body_settings={})
  # options in body_settings:
  #       show_lines(position of lines) = "outer"/"inner"
  #       show_headings(display or not) = true/false
  #       orientation(orientation)      = "left"/"center"/"right"
  #       position(position)            = "left"/"center"/"right"
  #       bold_header(header bold?)     = true/false
  #       font_size(font_size)          = any integer(e.g. 32)
  #       text_align(alignment)         = "left"/"center"/"right"
  def self.generate_personal_report_body(pdf, source_type, source_id, format, body_settings={})
    body_settings[:show_lines] ||= "outer"
    body_settings[:show_headings] ||= true
    body_settings[:orientation] ||= "center"
    body_settings[:position] ||= "center"
    body_settings[:bold_header] ||= false
    body_settings[:font_size] ||= 32
    body_settings[:text_align] ||= "center"

    if source_type == "query"
      #query
      @people = QueryHeader.find(source_id.to_i).run
    else
      #list
      @people = ListHeader.find(source_id.to_i).people_on_list
    end

    if @people.empty?
      pdf.text "No matching records found.", :font_size => body_settings[:font_size], :justification => body_settings[:text_align]
      return
    end


    PDF::SimpleTable.new do |tab|
      OutputPdf::PERSONAL_REPORT_FORMAT[format].each_key do |i|
        tab.column_order.push(OutputPdf::PERSONAL_REPORT_FORMAT[format][i])
      end

      OutputPdf::PERSONAL_REPORT_FORMAT[format].each_key do |i|
        tab.columns[OutputPdf::PERSONAL_REPORT_FORMAT[format][i]] = PDF::SimpleTable::Column.new(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]) { |col| col.heading = i}
      end

      tab.show_lines    = body_settings[:show_lines].to_sym
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation].to_sym
      tab.position      = body_settings[:position].to_sym
      tab.bold_headings = body_settings[:bold_header]

      data = Array.new
      @people.each do |person|
        if(!person.primary_email.nil?)
          email_p=person.primary_email.address
        end
        if(!person.secondary_email.nil?)
          email_s=person.secondary_email.address
        end
         if(!person.primary_phone.nil?)
          phone_p=person.primary_phone.value
        end
        if(!person.secondary_phone.nil?)
          phone_s=person.secondary_phone.value
        end
        if(!person.primary_website.nil?)
          website_p=person.primary_website.value
        end
        if(!person.secondary_website.nil?)
          website_s=person.secondary_website.value
        end
        email = format_fields(email_p, email_s)
        phone = format_fields(phone_p, phone_s)
        website = format_fields(website_p, website_s)
        address = (person.primary_address.nil?) ? "" : person.primary_address.formatted_value

        data_row = Hash.new
        OutputPdf::PERSONAL_REPORT_FORMAT[format].each_key do |i|
          if (i.include?("FK"))
            data_row[i] = (person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).nil?) ? "" : person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).name
          else
            case i
            when "address" then data_row[i] = address
            when "phone" then data_row[i] = phone
            when "email" then data_row[i] = email
            when "website" then data_row[i] = website
            else data_row[i] = person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i])
            end
            
          end
        end

          data << data_row
      end
      puts "*************#{data}*********************"

      tab.data.replace data
      puts "*************#{tab.data}*********************"
      tab.render_on(pdf)
    end
  

  end

  # private method - generate_organisational_report_body
  # geneare_organisational_report_body(pdf, source_type, source_id, format, body_settings={})
  # options in body_settings:
  #       show_lines(position of lines) = "outer"/"inner"
  #       show_headings(display or not) = true/false
  #       orientation(orientation)      = "left"/"center"/"right"
  #       position(position)            = "left"/"center"/"right"
  #       bold_header(header bold?)     = true/false
  #       font_size(font_size)          = any integer(e.g. 32)
  #       text_align(alignment)         = "left"/"center"/"right"
  def self.generate_organisational_report_body(pdf, source_type, source_id, format, body_settings={})
    body_settings[:show_lines] ||= "outer"
    body_settings[:show_headings] ||= true
    body_settings[:orientation] ||= "center"
    body_settings[:position] ||= "center"
    body_settings[:bold_header] ||= false
    body_settings[:font_size] ||= 32
    body_settings[:text_align] ||= "center"

    if source_type == "query"
      #organisational query
    else
      #list - all organisations
      @organisations = Organisation.find(:all, :order => "id")
    end

    if @organisations.empty?
      pdf.text "No matching records found.", :font_size => body_settings[:font_size], :justification => body_settings[:text_align]
      return
    end


    PDF::SimpleTable.new do |tab|
      OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_key do |i|
        tab.column_order.push(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i])
      end

      OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_key do |i|
        tab.columns[OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i]] = PDF::SimpleTable::Column.new(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i]) { |col| col.heading = i}
      end

      tab.show_lines    = body_settings[:show_lines]
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation]
      tab.position      = body_settings[:position]
      tab.bold_headings = body_settings[:bold_header]

      data = Array.new
      @organisations.each do |organisation|
        email = format_fields(organisation.primary_email, organisation.secondary_email)
        phone = format_fields(organisation.primary_phone, organisation.secondary_phone)
        website = format_fields(organisation.primary_website, organisation.secondary_website)
        address = organisation.primary_address.formatted_value

        data_row = Hash.new
        OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_key do |i|
          if (i.include?("FK"))
            data_row[i] = (organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i]).nil?) ? "" : organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i]).name
          else
            case i
            when "address" then data_row[i] = address
            when "phone" then data_row[i] = phone
            when "email" then data_row[i] = email
            when "website" then data_row[i] = website
            else data_row[i] = organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i])
            end

          end
        end
      end

      tab.data.replace data
      tab.render_on(pdf)
    end
  end


  # private method - generate_header
  # geneare_header(pdf, source_type, source_id, header_settings={})
  # options in header_settings:
  #       image_position(position of image) = "left"/"center"/"right"
  #       title_position(position of title) = "left"/"center"/"right"
  #       font(font)                     = any font(e.g. "Times-Roman)
  #       font_size(font_size)           = any integer(e.g. 32)
  def self.generate_header(pdf, source_type, source_id, header_settings={})
    #default setting for pdf header
    header_settings[:image] ||= "#{RAILS_ROOT}/public/images/Amazon-logo.jpg"
    header_settings[:title] ||= "#{source_type}_#{source_id}"
    header_settings[:image_position] ||= "left"
    header_settings[:title_position] ||= "center"
    header_settings[:font] ||= "Times-Roman"
    header_settings[:font_size] ||= 32


    pdf.image header_settings[:image], :justification => header_settings[:image_position]
    pdf.select_font header_settings[:font]
    pdf.text "#{header_settings[:title]}\n\n", :font_size => header_settings[:font_size], :justification => header_settings[:title_position]
  end

  # private method - generate_body
  # geneare_body(pdf, source_type, source_id, body_settings={})
  # options in body_settings:
  #       show_lines(position of lines) = "outer"/"inner"
  #       show_headings(display or not) = true/false
  #       orientation(orientation)      = "left"/"center"/"right"
  #       position(position)            = "left"/"center"/"right"
  #       bold_header(header bold?)     = true/false
  #       font_size(font_size)          = any integer(e.g. 32)
  #       text_align(alignment)         = "left"/"center"/"right"
  def self.generate_body(pdf, source_type, source_id, body_settings={})
    body_settings[:show_lines] ||= "outer"
    body_settings[:show_headings] ||= true
    body_settings[:orientation] ||= "center"
    body_settings[:position] ||= "center"
    body_settings[:bold_header] ||= false
    body_settings[:font_size] ||= 16
    body_settings[:text_align] ||= "center"

    if source_type == "query"
      #query
      @people = QueryHeader.find(source_id.to_i).run
    else
      #list
      @people = ListHeader.find(source_id.to_i).people_on_list
    end
    if @people.empty?
      pdf.text "No matching records found.", :font_size => body_settings[:font_size], :justification => body_settings[:text_align]
      return
    end


    PDF::SimpleTable.new do |tab|
      if (source_type == "query" && !QueryHeader.find(source_id.to_i).query_selections.empty?)
        QueryHeader.find(source_id.to_i).query_selections.each do |i|
          tab.column_order.push("#{i.field_name}")
        end
        QueryHeader.find(source_id.to_i).query_selections.each do |i|
          tab.columns["#{i.field_name}"] = PDF::SimpleTable::Column.new("#{i.field_name}") {|col| col.heading = "#{i.field_name.humanize}"}
        end
      else
        OutputPdf::PERSON_DEFAULT_FORMAT.each_key do |i|
          tab.column_order.push("#{OutputPdf::PERSON_DEFAULT_FORMAT[i].downcase}")
        end

        OutputPdf::PERSON_DEFAULT_FORMAT.each_key do |i|
          tab.columns["#{OutputPdf::PERSON_DEFAULT_FORMAT[i].downcase}"] = PDF::SimpleTable::Column.new("#{OutputPdf::PERSON_DEFAULT_FORMAT[i].downcase}") { |col| col.heading = "#{i}"}
        end
      end




      tab.show_lines    = body_settings[:show_lines].to_sym
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation].to_sym
      tab.position      = body_settings[:position].to_sym
      tab.bold_headings = body_settings[:bold_header]

      data = Array.new
      @people.each do |person|
        primary_e = person.primary_email.nil? ? "" : person.primary_email.address
        secondary_e = person.secondary_email.nil? ? "" : person.secondary_email.address
        primary_p = person.primary_phone.nil? ? "" : person.primary_phone.complete_number
        secondary_p = person.secondary_phone.nil? ? "" : person.secondary_phone.complete_number
        primary_w = person.primary_website.nil? ? "" : person.primary_website.address
        secondary_w = person.secondary_website.nil? ? "" : person.secondary_website.address
        email = format_fields(primary_e, secondary_e)
        phone = format_fields(primary_p, secondary_p)
        website = format_fields(primary_w, secondary_w)
        address = (person.primary_address.nil?) ? "" : person.primary_address.formatted_value

        data_row = Hash.new
        OutputPdf::PERSON_DEFAULT_FORMAT.each_key do |i|
          if (i.include?("FK"))
            data_row[i] = (person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i]).nil?) ? "" : "#{person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i]).name}"
          else
            case i
            when "address" then data_row[i] = "#{address}"
            when "phone" then data_row[i] = "#{phone}"
            when "email" then data_row[i] = "#{email}"
            when "website" then data_row[i] = "#{website}"
            else data_row[i] = "#{person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i])}"
            end

          end
        end
        data << data_row
      end
      puts "*********************#{data.to_yaml}*****************************99"
      tab.data.replace data
      tab.render_on(pdf)
    end

#    PDF::SimpleTable.new do |tab|
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
#        @people.each do |person|
#          primary_e = person.primary_email.nil? ? "" : person.primary_email.address
#          secondary_e = person.secondary_email.nil? ? "" : person.secondary_email.address
#          primary_p = person.primary_phone.nil? ? "" : person.primary_phone.complete_number
#          secondary_p = person.secondary_phone.nil? ? "" : person.secondary_phone.complete_number
#          primary_w = person.primary_website.nil? ? "" : person.primary_website.address
#          secondary_w = person.secondary_website.nil? ? "" : person.secondary_website.address
#          email = format_fields(primary_e, secondary_e)
#          phone = format_fields(primary_p, secondary_p)
#          website = format_fields(primary_w, secondary_w)
#
#          data << { "system_id" => "#{person.id}", "name" => "#{person.name}", "email" => "#{email}", "phone" => "#{phone}", "website" => "#{website}" }
#
#        end
#        puts "*********************#{data.to_yaml}*****************************99"
#        tab.data.replace data
#        tab.render_on(pdf)
#      end
  end




  def self.format_fields(field_one, field_two)
    if field_two.nil?
      return field_one
    else
      return "#{field_one} #{field_two}"
    end
  end
  
end

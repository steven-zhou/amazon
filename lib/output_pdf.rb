module OutputPdf

  require "pdf/writer"
  require "pdf/simpletable"
  
  #if the field is FK(e.g. gender), the hash would be "Gender(FK)" => "gender"
  PERSONAL_REPORT_FORMAT = {"person_contact_report" => {"ID" => "id",
      "First Name" => "first_name",
      "Family Name" => "family_name",
      "Address" => "address",
      "Email" => "email",
      "Phone" => "phone",
      "Website" => "website"}}
  
  ORGANISATIONAL_REPORT_FORMAT = {
    "organisaiton_contact_report" => {"ID" => "id",
      "Full Name" => "first_name",
      "Registered Name" => "family_name",
      "Address" => "address",
      "Email" => "email",
      "Phone" => "phone",
      "Website" => "website"}
  }

  #The difference between report and non_report is with/without format
  #validate report format
  def self.personal_report_format_valid(format)
    OutputPdf::PERSONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  def self.organisational_report_format_valid(format)
    OutputPdf::ORGANISATIONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  #  generate personal report in pdf
  def self.generate_personal_report_pdf(source_type, source_id, format)
    pdf = PDF::Writer.new
    generate_report_header(pdf, source_type, source_id, format)
    generate_report_body(pdf, source_type, source_id, format)
    return pdf
  end

  # generate organisational report in pdf
  def self.generate_organisational_report_pdf(source_type, source_id, format, image, title, header_settings, body_settings)
    pdf = PDF::Writer.new
    generate_report_header(pdf, source_type, source_id, format, image, title, header_settings)
    generate_report_body(pdf, source_type, source_id, format, body_settings)
    return pdf
  end

  # generate pdf from source (non_report)
  def self.generate_pdf(source_type, source_id, header_settings={}, body_settings={})
    pdf = PDF::Writer.new
    generate_header(pdf, source_type, source_id, header_settings)
    generate_body(pdf, source_type, source_id, body_settings)
    return pdf
  end


  private

 
  #private method - generate_report_header
  #geneare_report_header(pdf, source_type, source_id, format, [image, title, {header_settings}])
  #options in header_settings:
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

  #private method - generate_report_body
  #geneare_report_body(pdf, source_type, source_id, format, [{header_settings}])
  #options in body_settings:
  #       show_lines(position of lines) = "outer"/"inner"
  #       show_headings(display or not) = true/false
  #       orientation(orientation)      = "left"/"center"/"right"
  #       position(position)            = "left"/"center"/"right"
  #       bold_header(header bold?)     = true/false
  #       font_size(font_size)          = any integer(e.g. 32)
  #       text_align(alignment)         = "left"/"center"/"right"
  def self.generate_report_body(pdf, source_type, source_id, format, body_settings={})
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
        tab.column[OutputPdf::PERSONAL_REPORT_FORMAT[format][i]] = PDF::SimpleTable::Column.new(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]) { |col| col.heading = i}
      end

      tab.show_lines    = body_settings[:show_lines]
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation]
      tab.position      = body_settings[:position]
      tab.bold_headings = body_settings[:bold_header]

      data = Array.new
      @people.each do |person|
        email = format_fields(person.primary_email, person.secondary_email)
        phone = format_fields(person.primary_phone, person.secondary_phone)
        website = format_fields(person.primary_website, person.secondary_website)
        address = person.primary_address.formatted_value

        data_row = Hash.new
        OutputPdf::PERSONAL_REPORT_FORMAT[format].each_key do |i|
          if (i.include?("FK"))
            data_row[i] = (person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).nil?) ? "" : person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).name
          else
            case i
            when "Address" then data_row[i] = address
            when "Phone" then data_row[i] = phone
            when "Email" then data_row[i] = email
            when "Website" then data_row[i] = website
            else data_row[i] = person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i])
            end
            
          end
        end
      end

      tab.data.replace data
      tab.render_on(pdf)
    end
  end


   #private method - generate_header
  #geneare_header(pdf, source_type, source_id, [image, title, {header_settings}])
  #options in header_settings:
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

    #private method - generate_body
  #geneare_body(pdf, source_type, source_id, [{header_settings}])
  #options in body_settings:
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
        tab.column[OutputPdf::PERSONAL_REPORT_FORMAT[format][i]] = PDF::SimpleTable::Column.new(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]) { |col| col.heading = i}
      end

      tab.show_lines    = body_settings[:show_lines]
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation]
      tab.position      = body_settings[:position]
      tab.bold_headings = body_settings[:bold_header]

      data = Array.new
      @people.each do |person|
        email = format_fields(person.primary_email, person.secondary_email)
        phone = format_fields(person.primary_phone, person.secondary_phone)
        website = format_fields(person.primary_website, person.secondary_website)
        address = person.primary_address.formatted_value

        data_row = Hash.new
        OutputPdf::PERSONAL_REPORT_FORMAT[format].each_key do |i|
          if (i.include?("FK"))
            data_row[i] = (person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).nil?) ? "" : person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i]).name
          else
            case i
            when "Address" then data_row[i] = address
            when "Phone" then data_row[i] = phone
            when "Email" then data_row[i] = email
            when "Website" then data_row[i] = website
            else data_row[i] = person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i])
            end

          end
        end
      end

      tab.data.replace data
      tab.render_on(pdf)
    end
  end




  def self.format_fields(field_one, field_two)
    if field_two.nil?
      return field_one
    else
      return "#{field_one}\n#{field_two}"
    end
  end
  
end

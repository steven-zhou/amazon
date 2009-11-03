module OutputPdf

  require "pdf/writer"
  require "pdf/simpletable"
  
  # if the field is FK(e.g. gender), the hash would be "Gender(FK)" => "gender"
  PERSONAL_REPORT_FORMAT = {"person_contact_report" =>[ {"ID" => "id"},
      {"First Name" => "first_name"},
      {"Family Name" => "family_name"},
      {"Email" => "email"},
      {"Phone" => "phone"},
      {"Website" => "website"},
      {"Address" => "address"}]}
  
  ORGANISATIONAL_REPORT_FORMAT = {"organisaiton_contact_report" => [{"ID" => "id"},
      {"Full Name" => "full_name"},
      {"Registered Name" => "registered_name"},
      {"Email" => "email"},
      {"Phone" => "phone"},
      {"Website" => "website"},
      {"Address" => "address"}]}

  SYSTEM_LOG_REPORT_FORMAT = {"system_log_report" => [{"ID" => "id"},
      {"Date" => "created_at"},
      {"User" => "login_account.user_name"},
      {"IP Address" => "ip_address"},
      {"Controller" => "controller"},
      {"Action" => "action"},
      {"Message" => "message"}]}


  PERSON_DEFAULT_FORMAT = [{"ID" => "id"}, {"First Name" => "first_name"}, {"Family Name"=> "family_name"}, {"Address" => "address"},
    {"Email" => "email"}, {"Phone" => "phone"}, {"Website" => "website"}]
                          

  # The difference between report and non_report is with/without format
  # validate personal report format
  def self.personal_report_format_valid(format)
    OutputPdf::PERSONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  # validate personal report format
  def self.organisational_report_format_valid(format)
    OutputPdf::ORGANISATIONAL_REPORT_FORMAT.has_key?(format.to_s)
  end

  def self.system_log_report_format_valid(format)
    OutputPdf::SYSTEM_LOG_REPORT_FORMAT.has_key?(format.to_s)
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
  def self.generate_personal_report_pdf(source_type, source_id, format,list_report, header_settings={}, body_settings={})
    pdf = PDF::Writer.new
    generate_report_header(pdf, source_type, source_id, format,list_report, header_settings)
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

  def self.generate_system_log_report_pdf(report_type, system_log_entries, report_format)
    pdf = PDF::Writer.new
    generate_report_header(pdf, nil, nil, nil, nil, {:title => "System Log"})
    generate_system_log_report_body(pdf, system_log_entries)
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

  def self.generate_report_header(pdf, source_type, source_id, format,list_report, header_settings={})
    #default setting for pdf header
    header_settings[:image] ||= "#{RAILS_ROOT}/public/images/Amazon-logo.jpg"
    header_settings[:title] ||= "#{format.gsub("_"," ").titleize} From <#{list_report}>"
    header_settings[:image_position] ||= "left"
    header_settings[:title_position] ||= "center"
    header_settings[:font] ||= "Times-Roman"
    header_settings[:font_size] ||= 18


    pdf.image header_settings[:image], :justification => header_settings[:image_position].to_sym
    pdf.select_font header_settings[:font]
    pdf.text "#{header_settings[:title]}\n\n", :font_size => header_settings[:font_size], :justification => header_settings[:title_position].to_sym
  end


  def self.generate_personal_report_body(pdf, source_type, source_id, format, body_settings={})
    body_settings[:show_lines] ||= "outer"
    body_settings[:show_headings] ||= true
    body_settings[:orientation] ||= "center"
    body_settings[:position] ||= "center"
    body_settings[:bold_header] ||= false
    body_settings[:font_size] ||= 18
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
      OutputPdf::PERSONAL_REPORT_FORMAT[format].each_index do |i|
        tab.column_order.push(OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0])
      end

      OutputPdf::PERSONAL_REPORT_FORMAT[format].each_index do |i|
        tab.columns[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = PDF::SimpleTable::Column.new(OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]) { |col| col.heading = "#{OutputPdf::PERSONAL_REPORT_FORMAT[format][i].keys[0]}"}
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
        address = (person.primary_address.nil?) ? "" : person.primary_address.first_line 
        if(!(person.primary_address.nil?))
          address+="\n" + person.primary_address.second_line
        end


        data_row = Hash.new
        OutputPdf::PERSONAL_REPORT_FORMAT[format].each_index do |i|
          if (PERSONAL_REPORT_FORMAT[format][i].keys[0].include?("FK"))
            data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = (person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]).nil?) ? "" : person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]).name
          else
            case OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]
            when "address" then data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = address
            when "phone" then data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = phone
            when "email" then data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = email
            when "website" then data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = website
            else data_row[OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0]] = person.__send__(OutputPdf::PERSONAL_REPORT_FORMAT[format][i].values[0])
            end
            
          end
        end

        data << data_row
      end


      tab.data.replace data
      
      tab.render_on(pdf)
    end
  

  end

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
      OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_index do |i|
        tab.column_order.push(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0])
      end

      OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_index do |i|
        tab.columns[OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]] = PDF::SimpleTable::Column.new(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]) { |col| col.heading = OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].keys[0]}
      end


      tab.show_lines    = body_settings[:show_lines].to_sym
      tab.show_headings = body_settings[:show_headings]
      tab.orientation   = body_settings[:orientation].to_sym
      tab.position      = body_settings[:position].to_sym
      tab.bold_headings = body_settings[:bold_header]


      data = Array.new
      @organisations.each do |organisation|
        if(!organisation.primary_email.nil?)
          email_p=organisation.primary_email.address
        end
        if(!organisation.secondary_email.nil?)
          email_s=organisation.secondary_email.address
        end
        if(!organisation.primary_phone.nil?)
          phone_p=organisation.primary_phone.value
        end
        if(!organisation.secondary_phone.nil?)
          phone_s=organisation.secondary_phone.value
        end
        if(!organisation.primary_website.nil?)
          website_p=organisation.primary_website.value
        end
        if(!organisation.secondary_website.nil?)
          website_s=organisation.secondary_website.value
        end

        email = format_fields(email_p, email_s)
        phone = format_fields(phone_p, phone_s)
        website = format_fields(website_p, website_s)
        #        if(!(organisation.primary_address.blank?))
        #          address = organisation.primary_address.first_line + organisation.primary_address.second_line
        #        end

        address = (organisation.primary_address.nil?) ? "" : organisation.primary_address.formatted_value


        data_row = Hash.new
        OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format].each_index do |i|
          if (OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].keys[0].include?("FK"))
            data_row[OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]] = (organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]).nil?) ? "" : organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]).name
          else
            case OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]
            when "address" then data_row["address"] = address
            when "phone" then data_row["phone"] = phone
            when "email" then data_row["email"] = email
            when "website" then data_row["website"] = website
            else data_row[OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0]] = organisation.__send__(OutputPdf::ORGANISATIONAL_REPORT_FORMAT[format][i].values[0])
            end

          end
        end
        data << data_row
      end
 

      tab.data.replace data
      tab.render_on(pdf)
    end
  end

  def self.generate_system_log_report_body(pdf, system_log_entries)

    if system_log_entries.empty?
      pdf.text "No matching records found.", :font_size => 32, :justification => :center
      return
    end

    PDF::SimpleTable.new do |tab|

      tab.column_order.push(*%w(system_id log_date user ip_address controller action message))

      tab.columns["system_id"] = PDF::SimpleTable::Column.new("system_id") { |col|
        col.heading = "ID"
      }

      tab.columns["log_date"] = PDF::SimpleTable::Column.new("log_date") { |col|
        col.heading = "Date"
      }

      tab.columns["user"] = PDF::SimpleTable::Column.new("user") { |col|
        col.heading = "User"
      }

      tab.columns["ip_address"] = PDF::SimpleTable::Column.new("ip_address") { |col|
        col.heading = "IP Address"
      }

      tab.columns["controller"] = PDF::SimpleTable::Column.new("controller") { |col|
        col.heading = "Controller"
      }

      tab.columns["action"] = PDF::SimpleTable::Column.new("action") { |col|
        col.heading = "Action"
      }

      tab.columns["message"] = PDF::SimpleTable::Column.new("message") { |col|
        col.heading = "Message"
      }


      tab.show_lines    = :outer
      tab.show_headings = true
      tab.orientation   = :center
      tab.position      = :center
      tab.bold_headings = false

      data = Array.new

      for log_entry in system_log_entries do

        data << { "system_id" => "#{log_entry.id}", "log_date" => "#{log_entry.created_at.strftime('%a %d %b %Y %H:%M:%S')}", "user" => "#{log_entry.login_account.user_name} - (#{log_entry.login_account.person.name})", "ip_address" => "#{log_entry.ip_address}", "controller" => "#{log_entry.controller}", "action" => "#{log_entry.action}", "message" => "#{log_entry.message}" }

      end

      tab.data.replace data
      tab.render_on(pdf)
    end

  end


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
        tab.column_order.push("id")
        QueryHeader.find(source_id.to_i).query_selections.each do |i|
          tab.column_order.push("#{i.field_name}")
        end
        tab.columns["id"] = PDF::SimpleTable::Column.new("id") {|col| col.heading = "ID"}
        QueryHeader.find(source_id.to_i).query_selections.each do |i|
          tab.columns["#{i.field_name}"] = PDF::SimpleTable::Column.new("#{i.field_name}") {|col| col.heading = "#{i.field_name.humanize}"}
        end
      else
        OutputPdf::PERSON_DEFAULT_FORMAT.each_index do |i|
          tab.column_order.push("#{OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]}")
        end

        OutputPdf::PERSON_DEFAULT_FORMAT.each_index do |i|
          tab.columns["#{OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]}"] = PDF::SimpleTable::Column.new("#{OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]}") { |col| col.heading = "#{OutputPdf::PERSON_DEFAULT_FORMAT[i].keys[0]}"}
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
        if (source_type == "query" && !QueryHeader.find(source_id.to_i).query_selections.empty?)
          data_row["id"] = "#{person.id}"
          QueryHeader.find(source_id.to_i).query_selections.each do |i|
            if i.data_type.include?("Integer FK")
              data_row["#{i.field_name}"] = person.__send__(i.field_name).nil? ? "" : "#{person.__send__(i.field_name).name}"
            else
              data_row["#{i.field_name}"] = person.__send__(i.field_name)
            end
          end
        else
          OutputPdf::PERSON_DEFAULT_FORMAT.each_index do |i|
            if (OutputPdf::PERSON_DEFAULT_FORMAT[i].keys[0].include?("FK"))
              data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = (person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]).nil?) ? "" : "#{person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]).name}"
            else
              case OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]
              when "address" then data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = "#{address}"
              when "phone" then data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = "#{phone}"
              when "email" then data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = "#{email}"
              when "website" then data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = "#{website}"
              else data_row[OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0]] = "#{person.__send__(OutputPdf::PERSON_DEFAULT_FORMAT[i].values[0])}"
              end

            end
          end
        end
        
        data << data_row
      end
      tab.data.replace data
      tab.render_on(pdf)
    end
  end




  def self.format_fields(field_one, field_two)
    if field_two.nil?
      return field_one
    else
      return "#{field_one} \n #{field_two}"
    end
  end
  
end

module MasterDocsHelper
  def format_masterdoc(doc)
    first_line = "#{doc.doc_number}".squeeze(" ").strip
    second_line = "#{doc.doc_reference} #{doc.short_name}".squeeze(" ").strip
    third_line = "#{doc.issue_date} #{doc.expiry_date} #{doc.action_taken}".squeeze(" ").strip
    formatted = ""
    formatted += "#{first_line} <br/>" unless first_line.blank?
    formatted += "#{second_line} <br/>" unless second_line.blank?
    formatted += "#{third_line} <br/>" unless third_line.blank?
    return formatted
  end

  def masterdoc_type_options
    types = MasterDocType.all
    types.collect{|type| [type.name, type.id]}
  end
end

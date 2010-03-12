class PersonMailTemplate < MailTemplate

  def self.active_record
    @mail_templates = PersonMailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

  def self.initiate_template_id

    PersonMailTemplate.find_by_name("Membership Initiate Template").id
  end

  def self.inreview_template_id
    
    PersonMailTemplate.find_by_name("Membership Review Template").id

  end

end

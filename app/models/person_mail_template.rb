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

  def self.approve_template_id
    PersonMailTemplate.find_by_name("Membership Approve Template").id
  end

  def self.reject_template_id
    PersonMailTemplate.find_by_name("Membership Reject Template").id
  end
end

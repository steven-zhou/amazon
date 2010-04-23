class PersonEmailTemplate < EmailTemplate

  def self.active_record
    @mail_templates = PersonEmailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

  def self.initiate_template_id
    PersonEmailTemplate.find_by_name("Membership Initiate Email Template").id
  end

  def self.inreview_template_id
    PersonEmailTemplate.find_by_name("Membership Review Email Template").id
  end

  def self.approve_template_id
    PersonEmailTemplate.find_by_name("Membership Approve Email Template").id
  end

  def self.reject_template_id
    PersonEmailTemplate.find_by_name("Membership Reject Email Template").id
  end
end

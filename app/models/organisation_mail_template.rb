class OrganisationMailTemplate < MailTemplate

  def self.active_record
    @mail_templates = OrganisationMailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

end

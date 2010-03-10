class OrganisationEmailTemplate < EmailTemplate

  def self.active_record
    @mail_templates = OrganisationEmailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

end

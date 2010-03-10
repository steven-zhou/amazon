class PersonEmailTemplate < EmailTemplate

  def self.active_record
    @mail_templates = PersonEmailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

end

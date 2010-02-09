class EmailTemplate < MessageTemplate


  def self.active_record
    @email_templates = EmailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end


end

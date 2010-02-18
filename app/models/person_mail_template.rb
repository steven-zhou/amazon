class PersonMailTemplate < MailTemplate

  def self.active_record
    @mail_templates = PersonMailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end


end

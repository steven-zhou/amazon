class MailTemplate < MessageTemplate


  def self.active_record
    @mail_templates = MailTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end


end

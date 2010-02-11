class MessageTemplate < ActiveRecord::Base

  validates_presence_of :name

  validates_uniqueness_of :name, :scope => "type"

 def self.active_record
    @mail_templates = self.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end
end

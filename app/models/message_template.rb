class MessageTemplate < ActiveRecord::Base

  validates_presence_of :name

  validates_uniqueness_of :name

  def self.active_record
    @message_templates = MessageTemplate.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

end

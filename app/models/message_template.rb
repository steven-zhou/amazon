class MessageTemplate < ActiveRecord::Base

  validates_presence_of :name

  validates_uniqueness_of :name, :scope => "type"

  belongs_to :mail_merge_category, :foreign_key => "mail_merge_category_id"

  after_validation_on_create :set_to_be_removed_and_active

  def self.active_record
    @mail_templates = self.find(:all, :conditions => ["to_be_removed = false"], :order => 'name')
  end

  def set_to_be_removed_and_active
    self.to_be_removed ||= false

  end


end

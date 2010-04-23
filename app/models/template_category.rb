class TemplateCategory < AmazonSetting

  acts_as_list

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A mail merge category already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority
  has_many :message_templates

  def self.active_template_category
    @template_category = TemplateCategory.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
end

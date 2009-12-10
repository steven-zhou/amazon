class Title < AmazonSetting

  acts_as_list
  has_many :primary_title_owners, :class_name => "Person", :foreign_key => "primary_title_id"
  has_many :second_title_owners, :class_name => "Person", :foreign_key => "second_title_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A title already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_title
    @title = Title.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end
  
end

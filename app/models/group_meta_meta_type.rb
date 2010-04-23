class GroupMetaMetaType < TagMetaType

  acts_as_list

  has_many :group_meta_types, :class_name => "GroupMetaType", :foreign_key => "tag_meta_type_id", :order => "name"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A group meta meta type already exists with the same name."
  default_scope :order => "name ASC"
  after_create :assign_priority
  before_destroy :reorder_priority


  def self.find_custom_group
    GroupMetaMetaType.find_by_name("Custom")
  end

  def self.find_security_group
    GroupMetaMetaType.find_by_name("Security")
  end



  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end

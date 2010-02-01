class SystemPermissionMetaMetaType < TagMetaType

  # For permission modules

  acts_as_list

  has_many :system_permission_meta_types, :class_name => "SystemPermissionMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A permission meta meta type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority
  default_scope :order => "name asc"

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end

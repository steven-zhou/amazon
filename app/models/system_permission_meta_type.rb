class SystemPermissionMetaType < TagType

  # For controllers

  acts_as_list

  belongs_to :system_permission_meta_meta_type, :class_name => "SystemPermissionMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :system_permission_types, :class_name => "SystemPermissionType", :foreign_key => "tag_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_meta_type_id, :message => "A system permission meta type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end


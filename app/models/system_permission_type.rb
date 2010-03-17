class SystemPermissionType < Tag

  # For methods inside controllers

  acts_as_list

  belongs_to :system_permission_meta_type, :class_name => "SystemPermissionMetaType", :foreign_key => "tag_type_id"

  has_many :group_permissions
  has_many :group_types, :through => :group_permissions, :uniq => true

  validates_presence_of :name

  default_scope :order => "name ASC"
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


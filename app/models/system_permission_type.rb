class SystemPermissionType < Tag

  # For methods inside controllers

  acts_as_list

  belongs_to :system_permission_controller, :class_name => "SystemPermissionController", :foreign_key => "tag_type_id"

  has_many :group_permissions
  has_many :user_groups, :through => :group_permissions

  validates_presence_of :name

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


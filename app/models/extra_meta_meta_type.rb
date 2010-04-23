class ExtraMetaMetaType < TagMetaType

  acts_as_list

  has_many :extra_meta_types, :class_name => "ExtraMetaType", :foreign_key => "tag_meta_type_id"
  def self.extra_custom_field
    ExtraMetaMetaType.find_by_name("Custom Field")
  end


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

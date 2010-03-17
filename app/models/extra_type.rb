class ExtraType < Tag

   acts_as_list

  belongs_to :extra_meta_type, :class_name => "ExtraMetaType", :foreign_key => "tag_type_id"

  default_scope :order => "position ASC"
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

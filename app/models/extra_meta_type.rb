class ExtraMetaType < TagType
 acts_as_list

  belongs_to :extra_meta_meta_type, :class_name => "ExtraMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :extra_types, :class_name => "ExtraType", :foreign_key => "tag_type_id"

  

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

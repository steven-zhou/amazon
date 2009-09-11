class TableMetaMetaType < TagMetaType

  acts_as_list

  has_many :table_meta_types, :class_name => "TableMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A table meta meta type already exists with the same name."

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

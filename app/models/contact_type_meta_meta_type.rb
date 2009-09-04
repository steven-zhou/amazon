class ContactTypeMetaMetaType < TagMetaType

  acts_as_list

  has_many :contact_type_meta_types, :class_name => "ContactTypeMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A contact type meta meta type already exists with the same name."

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

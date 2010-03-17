class GroupMetaType < TagType

  acts_as_list

  belongs_to :group_meta_meta_type, :class_name => "GroupMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :group_types, :class_name => "GroupType", :foreign_key => "tag_type_id"
  default_scope :order => "name ASC"
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_meta_type_id, :message => "A group meta type already exists with the same name."

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


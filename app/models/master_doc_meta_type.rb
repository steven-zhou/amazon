class MasterDocMetaType < TagType

  acts_as_list

  belongs_to :master_doc_meta_meta_type, :class_name => "MasterDocMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :master_doc_types, :class_name => "MasterDocType", :foreign_key => "tag_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_meta_type_id, :message => "A master doc meta type already exists with the same name."

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


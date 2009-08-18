class MasterDocMetaMetaType < TagMetaType

  acts_as_list

  has_many :master_doc_meta_types, :class_name => "MasterDocMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A master doc meta meta type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_master_doc_meta_meta_type
    @mdmmt = MasterDocMetaMetaType.find_all_by_status(true)
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end

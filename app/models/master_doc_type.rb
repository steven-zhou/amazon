class MasterDocType < Tag

  acts_as_list

  belongs_to :master_doc_meta_type, :class_name => "MasterDocMetaType", :foreign_key => "tag_type_id"
  has_many :master_docs, :class_name => "MasterDoc", :foreign_key => "master_doc_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_type_id, :message => "A master doc meta type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.active_master_doc_meta_meta_type
    @mdmt = MasterDocMetaType.find_all_by_status(true)
  end


  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end


end


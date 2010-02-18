class TableMetaType < TagType

  acts_as_list

  belongs_to :table_meta_meta_type, :class_name => "TableMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :table_types, :class_name => "TableType", :foreign_key => "tag_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_meta_type_id, :message => "A table meta type already exists with the same name."

  after_create :assign_priority
  before_destroy :reorder_priority

  def self.personal_duplication_source
    TableMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", TableMetaMetaType.find_by_name("people").id], :order => "name")
  end

  def self.organisational_duplication_source
    TableMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", TableMetaMetaType.find_by_name("organisations").id], :order => "name")
  end

  def self.mmt_name_finder(name)
    @name_id = TableMetaMetaType.find_by_name(name).id
    TableMetaType.find(:all, :conditions => ["tag_meta_type_id=? and status =true", @name_id], :order => "name")
  end

    def self.name_finder(name)
    TableMetaType.find(:first, :conditions => ["name=?", name], :order => "name")
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end


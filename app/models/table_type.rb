class TableType < Tag

  acts_as_list

  belongs_to :table_meta_type, :class_name => "TableMetaType", :foreign_key => "tag_type_id"
  #has_many :tables, :class_name => "Table", :foreign_key => "table_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :tag_type_id, :message => "A table type already exists with the same name."

  default_scope :order => "name ASC"
  after_create :assign_priority
  before_destroy :reorder_priority

  def self.mt_name_finder(name)
    @name_id = TableMetaType.find_by_name(name).id
    TableMetaType.find(:all, :conditions => ["tag_meta_type_id=? and status =true", @name_id], :order => "name")
  end

  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end


end


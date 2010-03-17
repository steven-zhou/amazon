class TableMetaMetaType < TagMetaType

  acts_as_list

  has_many :table_meta_types, :class_name => "TableMetaType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name

  default_scope :order => "name ASC"
  after_create :assign_priority
  before_destroy :reorder_priority


  def self.table_categroy(entity)
    if (entity == "person")
      TableMetaMetaType.find(:all, :conditions => ["category !=?", "organisation"], :order => "name")
    else
      TableMetaMetaType.find(:all, :conditions => ["category !=?", "person"], :order => "name")
    end
  end

  
  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

end

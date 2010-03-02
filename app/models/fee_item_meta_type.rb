class FeeItemMetaType < TagMetaType
  acts_as_list
   has_many :fee_item_types, :class_name => "FeeItemType", :foreign_key => "tag_meta_type_id"

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "A fee item meta type already exists with the same name."
  
  after_create :assign_priority,:update_to_be_removed_and_status
  before_destroy :reorder_priority

    def self.active_record
    FeeItemMetaType.find(:all,:conditions=>"status = true and to_be_removed= false")
  end




  private

  def assign_priority
    self.move_to_bottom
  end

  def reorder_priority
    self.remove_from_list
  end

    def update_to_be_removed_and_status

    self.to_be_removed = false
    self.status = true
  end
end

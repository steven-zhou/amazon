class FeeMetaType < TagType

  acts_as_list

  belongs_to :fee_meta_meta_type, :class_name => "FeeMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :fee_types, :class_name => "FeeType", :foreign_key => "tag_type_id"

  default_scope :order => "name ASC"
  named_scope :subscription_fee, :conditions => {:category => "subscription"}

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


class FeeMetaMetaType < TagMetaType

  acts_as_list

  has_many :fee_meta_types, :class_name => "FeeMetaType", :foreign_key => "tag_meta_type_id"

  named_scope :subscription_fee, :conditions => {:category => "subscription"}
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
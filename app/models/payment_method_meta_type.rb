class PaymentMethodMetaType < TagType

  acts_as_list
  belongs_to :payment_method_meta_meta_type, :class_name => "PaymentMethodMetaMetaType", :foreign_key => "tag_meta_type_id"
  has_many :payment_method_types, :class_name => "PaymentMethodMetaType", :foreign_key => "tag_type_id"

  named_scope :manual, :conditions => {:tag_meta_type_id => PaymentMethodMetaMetaType.find_by_name("Manual").id, :status => true, :to_be_removed => false}
  named_scope :direct_debit, :conditions => {:tag_meta_type_id => PaymentMethodMetaMetaType.find_by_name("Direct Debit").id, :status => true, :to_be_removed => false}

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


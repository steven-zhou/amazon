class PaymentMethodType < TagType

  acts_as_list
  belongs_to :payment_method_meta_type, :class_name => "PaymentMethodMetaType", :foreign_key => "tag_meta_type_id"
  has_many :payment_methods

  named_scope :manual, :conditions => {:tag_meta_type_id => PaymentMethodMetaType.find_by_name("Manual").id, :status => true, :to_be_removed => false}


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


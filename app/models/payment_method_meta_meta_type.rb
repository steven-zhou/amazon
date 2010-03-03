class PaymentMethodMetaMetaType < TagMetaType

  acts_as_list
  has_many :payment_method_meta_types, :class_name => "PaymentMethodMetaType", :foreign_key => "tag_meta_type_id"
  
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

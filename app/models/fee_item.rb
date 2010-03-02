class FeeItem < ActiveRecord::Base

    belongs_to :fee_item_type, :class_name => "FeeItemType", :foreign_key => "tag_type_id"
    belongs_to :tax_item , :class_name => "TaxItem", :foreign_key => "tax_items_id"
    belongs_to :payment_frequency , :class_name => "PaymentFrequency", :foreign_key => "pay_frequency_id"
    belongs_to :link_module, :class_name => "LinkModule",:foreign_key=>"link_module_id"
    validates_presence_of :name
    validates_uniqueness_of :name

    default_scope :order => "name ASC"

    before_create :update_to_be_removed_and_status



  private

  def update_to_be_removed_and_status

    self.to_be_removed = false
    self.active = true
  end
end

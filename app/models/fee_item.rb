class FeeItem < ActiveRecord::Base

  belongs_to :tax_item , :class_name => "TaxItem", :foreign_key => "tax_items_id"
  belongs_to :payment_frequency , :class_name => "PaymentFrequency", :foreign_key => "pay_frequency_id"
  belongs_to :link_module, :class_name => "LinkModule",:foreign_key=>"link_module_id"
  has_many :membership_fees,:class_name=>"MembershipFee",:foreign_key=>"fee_item_id"

  validates_presence_of :name, :tag_type_id, :amount
  validates_uniqueness_of :name

  named_scope :active, :conditions => {:status => true, :to_be_removed => false}, :order => "name"
  named_scope :inactive, :conditions => {:status => false}, :order => "name"
  named_scope :removed, :conditions => {:to_be_removed => true}, :order => "name"
  default_scope :order => "name ASC"

  before_create :update_to_be_removed_and_status



  private

  def update_to_be_removed_and_status

    self.to_be_removed = false
    self.active = true
  end
end

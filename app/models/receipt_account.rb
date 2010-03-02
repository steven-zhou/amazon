class ReceiptAccount < ActiveRecord::Base

  belongs_to :link_module
  has_many :transaction_allocations
  has_many :membership_fees ,:class_name =>"MembershipFee",:foreign_key => "receipt_account_id"
  validates_uniqueness_of :name
  validates_presence_of :name, :link_module_id

  def self.active
    ReceiptAccount.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => "name")
  end
end

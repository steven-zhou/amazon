class ReceiptAccount < ActiveRecord::Base

  belongs_to :link_module
  has_many :transaction_allocations

  validates_uniqueness_of :name
  validates_presence_of :name, :link_module_id

  def self.active
    ReceiptAccount.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => "name")
  end
end

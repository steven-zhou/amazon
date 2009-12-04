class ReceiptAccount < ActiveRecord::Base

  belongs_to :link_module
  has_many :transaction_allocations
  #  belongs_to :module_name, :class_name => 'LinkModule',:primary_key => "name", :foreign_key => 'link_module_name',  :autosave => true

  validates_uniqueness_of :name
  validates_presence_of :name, :link_module_id


end

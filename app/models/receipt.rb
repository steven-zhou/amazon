class Receipt < ActiveRecord::Base

  attr_accessor :extension

  belongs_to :deposit
  belongs_to :receipt_account
  belongs_to :campaign
  belongs_to :source
  belongs_to :entity, :polymorphic => true
  

  validates_presence_of :deposit_id, :entity_type, :entity_id
  validates_uniqueness_of :entity_id, :scope => ["deposit_id", "entity_type"], :if => :is_extension?
  validates_presence_of :receipt_account_id, :amount, :unless => :is_extension?
  validates_uniqueness_of :receipt_account_id, :scope => ["deposit_id", "entity_type", "entity_id"], :unless => :is_extension?


  def is_extension?
    extension
  end
end

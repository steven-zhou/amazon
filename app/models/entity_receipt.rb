class EntityReceipt < Receipt

  belongs_to :deposit
  belongs_to :entity, :polymorphic => true
#  belongs_to :campaign
  has_many :receipt_allocations, :dependent => :destroy

  validates_presence_of :deposit_id, :entity_type, :entity_id
  validates_uniqueness_of :entity_id, :scope => ["deposit_id", "entity_type"]
  
end

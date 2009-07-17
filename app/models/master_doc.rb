class MasterDoc < ActiveRecord::Base
  belongs_to :master_doc_type
  belongs_to :entity, :polymorphic => true
  validates_presence_of :master_doc_type_id
end

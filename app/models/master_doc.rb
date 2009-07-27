class MasterDoc < ActiveRecord::Base
  acts_as_list :column => "priority_number"
  belongs_to :master_doc_type
  belongs_to :entity, :polymorphic => true
  validates_presence_of :master_doc_type_id

  before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    self.move_to_bottom
  end

  def update_priority_before_destroy
    self.remove_from_list
  end
end

class Extra < ActiveRecord::Base

  ################
  #  Associations
  ################

  belongs_to :entity, :polymorphic => true

  private

  def self.find_extra(group_id, entity_id)
    Extra.find(:all, :conditions => ["group_id = ? AND person_id = ?", group_id, entity_id]).try(:first)
  end
end
